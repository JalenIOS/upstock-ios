//
//  ContentView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import SwiftUI

struct UpstockContentView: View {
    
    
    var body: some View {
        ZStack {
            Color(.appGray)
                .ignoresSafeArea()
            
            
           
            VStack(spacing:0) {

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
                            
                            Image(systemName: "chart.xyaxis.line")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundStyle(Color.appGreenPrimary)
                            
                        }
                        Spacer()
                        
                        Text("$ 100,000.00")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.appGreenPrimary)
                        
                    }
                    .padding()
                    .padding(.horizontal, 10)
                    Divider()
                    
                }
            }
            .safeAreaInset(edge: .bottom) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    
                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]){
                        Image(systemName: "newspaper")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
//                        Spacer()
                        
                        Text("Feed")
                            .font(.footnote)
                    }
                    .foregroundStyle(Color.appGreenPrimary)
                    
                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                        Image(systemName: "chart.bar.xaxis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
//                        Spacer()

                        
                        Text("Reports")
                            .font(.footnote)
                    }
                    .foregroundStyle(Color.white.opacity(0.5))
                    
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
                        
//                        Spacer()

                        
                        Text("Portfolio")
                            .font(.footnote)
                    }
                    .foregroundStyle(Color.white.opacity(0.5))
                    
                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                        Image(systemName: "list.bullet.below.rectangle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
//                        Spacer()

                        
                        Text("Watchlist")
                            .font(.footnote)
                    }
                    .foregroundStyle(Color.white.opacity(0.5))
                    
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
                .padding()
                .compositingGroup()
                .background(.black.opacity(0.95))
                .shadow(color: Color.appGreenPrimary.opacity(0.15), radius: 50)
                
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


#Preview {
    UpstockContentView()
}
