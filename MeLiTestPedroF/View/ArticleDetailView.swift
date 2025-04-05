//
//  ArticleDetailView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 5/04/25.
//

import SwiftUI

//struct ArticleDetailView: View {
//    let article: Article
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                AsyncImage(url: URL(string: article.image_url)) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 250)
//                            .clipped()
//                            .cornerRadius(16)
//                    default:
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.3))
//                            .frame(height: 250)
//                            .cornerRadius(16)
//                    }
//                }
//
//                // Título
//                Text(article.title)
//                    .font(.title)
//                    .bold()
//                    .foregroundColor(.primary)
//
//                // Fecha
//                Text(formattedDate(from: article.published_at))
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//
//                // Resumen
//                Text(article.summary)
//                    .font(.body)
//                    .foregroundColor(.primary)
//
//                // Botón para abrir en Safari
//                Button(action: {
//                    if let url = URL(string: article.url) {
//                        UIApplication.shared.open(url)
//                    }
//                }) {
//                    HStack {
//                        Image(systemName: "safari")
//                        Text("Leer en el sitio")
//                    }
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(12)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Detalle")
//        .navigationBarTitleDisplayMode(.inline)
//        .background(Color(.systemBackground))
//    }
//
//    private func formattedDate(from isoDate: String) -> String {
//        let formatter = ISO8601DateFormatter()
//        guard let date = formatter.date(from: isoDate) else { return "" }
//
//        let displayFormatter = DateFormatter()
//        displayFormatter.dateStyle = .medium
//        return displayFormatter.string(from: date)
//    }
//}

import SwiftUI

struct ArticleDetailView: View {
    @StateObject private var viewModel: ArticleDetailViewModel

    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleDetailViewModel(article: article))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: viewModel.article.image_url)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .cornerRadius(16)
                    default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 250)
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
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}
