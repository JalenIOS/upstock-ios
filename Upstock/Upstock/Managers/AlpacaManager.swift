//
//  AlpacaManager.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import Foundation

class AlpacaManager: @unchecked Sendable {
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
    
    func queryStocks(for queryType: AlpacaRequestFor, urlAddOn: String? = nil) async throws -> Result<Data, AlpacaReqError> {
        print(config)
        
        let urlString = "\(queryType.getUrlString(addOn: urlAddOn))"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL(urlString))
        }
        
        var req = URLRequest(url: url)
        
        req.addValue(config.id, forHTTPHeaderField: AlpacaConfig.headerIdKey)
        req.addValue(config.secret, forHTTPHeaderField: AlpacaConfig.headerSecretKey)

        
        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            
//            if let rawResponse = String(data: data, encoding: .utf8) {
//                print("Raw Response: \(rawResponse)")
//            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return .failure(.invalidRequest)
            }
            return .success(data)
            
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
    case tickerInfo
    case tickerAsset
    
    func getUrlString(addOn: String? = nil) -> String {
        switch self {
        case .mostActives:
            return "https://data.alpaca.markets/v1beta1/screener/stocks/most-actives"
        case .tickerInfo:
            let baseUrl = "https://paper-api.alpaca.markets/v2/assets"
            if let addOn = addOn {
                return baseUrl + addOn
            }
            return baseUrl
            
        case .tickerAsset:
            let baseUrl = "https://data.alpaca.markets/v1beta1/logos"
            if let addOn = addOn {
                return baseUrl + addOn
            }
            return baseUrl
            
        }
    }
    
    var responseType: Decodable.Type {
        switch self {
        case .mostActives:
            return MostActiveResponse.self
        default:
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

struct TickerInfoResponse: Codable, Hashable {
    var id: String
    var classType: String
    var exchange: String
    var symbol: String
    var name: String
    var status: String
    var tradable: Bool
    var marginable: Bool
    var maintenanceMarginRequirement: Int
    var marginRequirementLong: String
    var marginRequirementShort: String
    var shortable: Bool
    var easyToBorrow: Bool
    var fractionable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case classType = "class"
        case exchange
        case symbol
        case name
        case status
        case tradable
        case marginable
        case maintenanceMarginRequirement = "maintenance_margin_requirement"
        case marginRequirementLong = "margin_requirement_long"
        case marginRequirementShort  = "margin_requirement_short"
        case shortable
        case easyToBorrow = "easy_to_borrow"
        case fractionable

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

struct TickerAssetResponse: Codable, Hashable  {
    var file: Data
}



enum AlpacaReqError: Error {
    case invalidURL(String)
    case networkError(Error)
    case invalidRequest
    case invalidData
    
}
