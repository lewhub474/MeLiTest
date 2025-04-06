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
                            Task {
                                await viewModel.fetchArticles()
                            }
                        }
                    )
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    } else if viewModel.showEmptyState {
                        Spacer()
                        Text("No se encontraron artículos.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Spacer()
                    } else if viewModel.showArticleList {
                        ScrollView {
                            ArticleListView(articles: viewModel.articles)
                        }
                        .scrollDismissesKeyboard(.interactively)
                        .cornerRadius(5)
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchArticles()
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .alert("Error", isPresented: viewModel.isPresentingError, actions: {
            Button("OK") {
                viewModel.dismissError()
            }
        }, message: {
            Text(viewModel.errorMessage ?? "")
        })
    }
}

#Preview {
    DashboardView()
}
