//
//  AlpacaManager.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import Foundation

actor AlpacaManager: Sendable {
    static let shared = AlpacaManager()
    var config: AlpacaConfig {
        if let id = Bundle.main.object(forInfoDictionaryKey: "ALPACA_ID") as? String,
           let secret = Bundle.main.object(forInfoDictionaryKey: "ALPACA_SECRET") as? String {
            let config = AlpacaConfig(id: id, secret: secret)
            
            return config
            
        }
        
        
        return AlpacaConfig(id: "", secret: "")


    }
    
    init(){
        
    }
    
    func queryStocks<T: Decodable>(for queryType: AlpacaRequestFor) async throws -> Result<T, AlpacaReqError> {
        print(config)
        
        let urlString = "\(queryType.urlString)"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL(urlString))
        }
        
        var req = URLRequest(url: url)
        
        req.addValue(config.id, forHTTPHeaderField: AlpacaConfig.headerIdKey)
        req.addValue(config.secret, forHTTPHeaderField: AlpacaConfig.headerSecretKey)

        
        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return .failure(.invalidRequest)
            }
//            if let rawResponse = String(data: data, encoding: .utf8) {
//                print("Raw Response: \(rawResponse)")
//            }
            
            let queriedData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(queriedData)
            
        } catch {
            return .failure(.invalidRequest)
        }
        
    }
}

struct AlpacaConfig: Codable, Hashable {
    var id: String
    var secret: String
    
    static let headerIdKey = "Apca-Api-Key-Id"
    static let headerSecretKey = "Apca-Api-Secret-Key"
}

enum AlpacaRequestFor {
    case mostActives
    
    var urlString: String {
        return "https://data.alpaca.markets/v1beta1/screener/stocks/most-actives"
    }
    
    var responseType: Decodable.Type {
        switch self {
        case .mostActives:
            return MostActiveResponse.self
        }
    }
}

struct MostActiveResponse: Codable, Hashable {
    var mostActives: [MostActiveItem]
    
    enum CodingKeys: String, CodingKey {
        case mostActives = "most_actives"
    }
}

struct MostActiveItem: Codable, Hashable {
    var symbol: String
    var tradeCount: Int64
    var volume: Int64
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case tradeCount = "trade_count"
        case volume
    }
}



enum AlpacaReqError: Error {
    case invalidURL(String)
    case networkError(Error)
    case invalidRequest
    case invalidData
    
}
