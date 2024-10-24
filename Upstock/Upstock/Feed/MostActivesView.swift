//
//  MostActivesView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import SwiftUI

struct MostActivesView: View {
    @State private var mostActives: [MostActiveItem] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing:5) {
            HStack {
                Text("TRENDING NOW 🔥")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
                
                Spacer()
                
//                Image(systemName: "chevron.right")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 8)
//                    .foregroundStyle(Color.gray)
//                    .padding(.trailing)
            }
            .padding([.horizontal, .top])

//                    .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 20) {
                    ForEach(mostActives, id: \.symbol) { t in
                        MostActiveItemView(mostActiveItem: t)
                        
                    }
                }
                .padding([.horizontal, .bottom])
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            Task {
                let result: Result<Data, AlpacaReqError> = try await AlpacaManager.shared.queryStocks(for: .mostActives)
                
                switch result {
                case .success(let data):
                    do {
                        let mostActives = try JSONDecoder().decode(MostActiveResponse.self, from: data)
                        
                        self.mostActives = mostActives.mostActives
                        
                    } catch {
                        print(error)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct MostActiveItemView: View {
    var mostActiveItem: MostActiveItem
    @State private var ticker: TickerInfoResponse?
    @State private var tickerImg: UIImage = UIImage()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                if let ticker = self.ticker {
                    VStack(alignment: .leading) {
                        Text(ticker.symbol)
                            .font(.body)
                            .fontWeight(.bold)
                        Text(ticker.name)
                            .font(.footnote)
                            .lineLimit(1)
                        
                    }
                    
                }
                
            }

            
        }
        .padding()
        .frame(width: 250, height: 250, alignment: .topLeading)
        .background(LinearGradient(colors: [.appGray, .appGray, .appGray, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 5))
//        .shadow(color: .orange.opacity(0.25), radius: 1)
//        .shadow(color: .red.opacity(0.25), radius: 1)
        .shadow(color: Color(.darkGray).opacity(0.125), radius: 10)

        .padding(.top)
        .onAppear {
            Task {
                let results: Result<Data, AlpacaReqError> = try await AlpacaManager.shared.queryStocks(for: .tickerInfo, urlAddOn: "/\(mostActiveItem.symbol)")
                switch results {
                case .success(let data):
//                    let strData = String(data: data, encoding: .utf8)
//                    print(strData)
                    
                    do {
                        let tickerData = try JSONDecoder().decode(TickerInfoResponse.self, from: data)
                        ticker = tickerData
                    } catch {
                        print(error)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        .onChange(of: ticker) {_,_ in
            if let ticker = ticker {
                Task {
                    let results: Result<Data, NinjaReqError> = try await NinjaManager.shared.getTickerImg(ticker: ticker.symbol)
                    switch results {
                    case .success(let data):
                        let strData = String(data: data, encoding: .utf8)
                        print(strData)
                        
//                        do {
//                            let tickerData = try JSONDecoder().decode(TickerAssetResponse.self, from: data)
//                            tickerImg = tickerData
//                        } catch {
//                            print(error)
//                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
                
            }
    }
}

//#Preview {
//    MostActivesView()
//}
