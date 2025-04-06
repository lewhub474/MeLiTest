//
//  ArticleCardView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

struct ArticleCard: View {
    @StateObject var viewModel: ArticleCardViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: viewModel.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(12)
                }
            }
            
            Text(viewModel.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
            
            Text(viewModel.formattedDate)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            Text(viewModel.summary)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(3)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}
