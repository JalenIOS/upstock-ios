//
//  StockChartView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/24/24.
//

import SwiftUI
import Charts

struct StockChartView: View {
    var ticker: TickerInfoResponse
    @State private var prices: [ChartPrice] = []
    
    var body: some View {
        VStack {
            Chart(prices, id: \.timestamp) { item in
                if let price = item.price,
                   let timestamp = item.timestamp {
                    LineMark(
                        x: .value("Closing price", price),
                        y: .value("Date", timestamp)
                    )
                    .foregroundStyle(Color.appGreenPrimary)
                    
                }
            }
            
        }
        .onAppear {
            Task {
                let result: Result<[StockBar], AlpacaReqError> = try await AlpacaManager.shared.getBarData(symbol: ticker.symbol)
                
                switch result {
                case .success(let stockBars):
                    print(stockBars)
                    
                    prices = stockBars.map( {
                        if let price = $0.close {
                            let dateFormatter = DateFormatter()
                            
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            
                            
                            return ChartPrice(price: price, timestamp: dateFormatter.date(from: $0.timestamp))
                            
                        }
                        
                        return ChartPrice(price: nil, timestamp: nil)
                        
                    } )
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
//        Chart(prices)
    }
}

struct ChartPrice: Codable, Hashable {
    var price: Double?
    var timestamp: Date?
}

