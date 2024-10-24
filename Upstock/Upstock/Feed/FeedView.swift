//
//  HomeView.swift
//  Upstock
//
//  Created by Jalen Arms on 10/23/24.
//

import SwiftUI

struct FeedView: View {
    
    
    var body: some View {
        VStack {
            VStack {
                GroupBox {
                    
                } label: {
                    Text("PORTFOLIO")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.gray)
                    
                    Text("$ 100,000.00")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                    
                    HStack(spacing:5) {
                        Image(systemName: "arrowtriangle.up.fill")
                        Text("275.00")
                        Text("1.75%")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.gray)
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.appGreenPrimary)
                }
                .padding()
            }
            
            MostActivesView()
            
            
            
            
                
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

//#Preview {
//    FeedView()
//}
