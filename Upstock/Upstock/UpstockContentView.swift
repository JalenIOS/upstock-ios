//
//  ContentView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import SwiftUI

struct UpstockContentView: View {
    @State private var currTabView: TabViewType = .feed
    
    var body: some View {
        ZStack {
            Color(.appGray)
                .ignoresSafeArea()
            
            
           
            VStack(spacing:0) {
                currTabView.view()
            }
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .safeAreaInset(edge: .top) {
                VStack {
                    HStack {
                        
                        HStack {
                            Text("Upstock")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(LinearGradient(colors: [.red, .orange], startPoint: .leading, endPoint: .trailing))
                                
                            
                            Image(systemName: "chart.xyaxis.line")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundStyle(Color.orange)
                            
                        }
                        Spacer()
                        
                        Text("$ 100,000.00")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.appGreenPrimary)
                        
                    }
                    .padding()
                    .padding(.horizontal, 10)
                    Divider()
                    
                }
            }
            .safeAreaInset(edge: .bottom) {
                AppTabBar(currTabView: $currTabView)
                
            }
            
            
        }
        .preferredColorScheme(.dark)
        .onAppear {
//            Task {
//                let data: Result<MostActiveResponse, AlpacaReqError> = try await AlpacaManager.shared.queryStocks(for: .mostActives)
//                print(data)
//            }
        }
    }
}

enum TabViewType {
    case feed
    case reports
    case portfolio
    case watchlist
    case account
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .feed:
            FeedView()
        default:
            EmptyView()
        }
    }
}

struct AppTabBar: View {
    @Binding var currTabView: TabViewType
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
            
            Button {
                currTabView = .feed
            } label: {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]){
                    Image(systemName: "newspaper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    
                    Text("Feed")
                        .font(.footnote)
                }
                .foregroundStyle(Color.appGreenPrimary)
                
            }
            
            Button {
                currTabView = .reports

            } label: {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                    Image(systemName: "chart.bar.xaxis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    
                    
                    Text("Reports")
                        .font(.footnote)
                }
                .foregroundStyle(Color.white.opacity(0.5))
                
            }
            
            Button {
                currTabView = .portfolio

            } label: {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]){
                    ZStack {
                        Image(systemName: "briefcase.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                        Text("💰")
                            .foregroundStyle(Color.appGreenPrimary)
                            .fontWeight(.bold)
                    }
                    
                    
                    
                    Text("Portfolio")
                        .font(.footnote)
                }
                .foregroundStyle(Color.white.opacity(0.5))
                
            }
            
            Button {
                currTabView = .watchlist

            } label: {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                    Image(systemName: "list.bullet.below.rectangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    
                    Text("Watchlist")
                        .font(.footnote)
                }
                .foregroundStyle(Color.white.opacity(0.5))
                
            }
            
            Button {
                currTabView = .account

            } label: {
                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    //                        Spacer()
                    
                    
                    Text("Account")
                        .font(.footnote)
                }
                .foregroundStyle(Color.white.opacity(0.5))
                
            }
            
        }
        .padding()
        .compositingGroup()
        .background(.black.opacity(0.95))
        .shadow(color: Color.appGreenPrimary.opacity(0.15), radius: 50)
        
    }
}






#Preview {
    UpstockContentView()
}
