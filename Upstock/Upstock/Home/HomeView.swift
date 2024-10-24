//
//  HomeView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.green)
            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.black, .black, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear {
            Task {
                let data: Result<MostActiveResponse, AlpacaReqError> = try await AlpacaManager.shared.queryStocks(for: .mostActives)
                print(data)
            }
        }
    }
}

#Preview {
    HomeView()
}
