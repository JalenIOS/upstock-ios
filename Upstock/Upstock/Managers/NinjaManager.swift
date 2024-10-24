//
//  NinjaManager.swift
//  Upstock
//
//  Created by Jalen Arms on 10/24/24.
//

import Foundation


class NinjaManager: @unchecked Sendable {
    static let shared = NinjaManager()
    private var configKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "NINJA_KEY") as? String ?? ""
    }
    
    init(){
        
    }
//    https://api.api-ninjas.com/v1/logo?ticker=\(ticker)
//    X-Api-Key
    
    func getTickerImg(ticker: String) async throws -> Result<Data, NinjaReqError> {
        
        guard let url = URL(string: "https://api.api-ninjas.com/v1/logo?ticker=\(ticker)") else { return .failure(.invalidURL) }
        
        let req = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                return .failure(.invalidRequest)
            }
            
            return .success(data)
                
            
//            return .failure(.invalidData)
            
        } catch {
            return .failure(.invalidRequest)
        }
                
    }
    
}

enum NinjaReqError: Error {
    case invalidRequest
    case networkError
    case invalidData
    case invalidURL
}
