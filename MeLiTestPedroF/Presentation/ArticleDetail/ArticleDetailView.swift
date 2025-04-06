//
//  ArticleDetailView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

struct ArticleDetailView: View {
    @StateObject private var viewModel: ArticleDetailViewModel
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleDetailViewModel(article: article))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: viewModel.article.imageUrl)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 250)
                            .clipped()
                            .cornerRadius(16)
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity, minHeight: 250)
                            .cornerRadius(16)
                    }
                }
                
                Text(viewModel.article.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                
                Text(viewModel.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(viewModel.article.summary)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Button(action: {
                    viewModel.openInSafari()
                }) {
                    HStack {
                        Image(systemName: "safari")
                        Text("Leer en el sitio")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}
