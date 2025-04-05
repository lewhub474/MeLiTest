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
                    SearchBar(
                        text: $viewModel.searchText,
                        onSearch: {
                            viewModel.fetchArticles()
                        }
                    )
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    } else {
                        if viewModel.articles.isEmpty {
                            VStack {
                                Spacer()
                                Text("No se encontraron artículos.")
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            ScrollView {
                                ArticleListView(articles: viewModel.articles)
                            }
                            .scrollDismissesKeyboard(.interactively)
                            .cornerRadius(5)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchArticles()
                }
            }.padding(.horizontal, 10)
        }
    }
}


#Preview {
    DashboardView()
}
