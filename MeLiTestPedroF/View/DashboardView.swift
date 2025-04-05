//
//  DashboardView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 4/04/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            BackgroundView {
                VStack(spacing: 16) {
                    SearchBar(text: $viewModel.searchText, onSearch: viewModel.fetchArticles)
                        .padding(.top)

                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ScrollView {
                            ArticleListView(articles: viewModel.articles)
                        }
                        .scrollDismissesKeyboard(.interactively)
                    }
                }
                .onAppear {
                    viewModel.fetchArticles()
                }
            }
        }
    }
}




import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            TextField("Buscar artículos...", text: $text)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.95))
                .cornerRadius(10)
                .submitLabel(.search)

            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 8) // espacio externo
    }
}

#Preview {
    DashboardView()
}
