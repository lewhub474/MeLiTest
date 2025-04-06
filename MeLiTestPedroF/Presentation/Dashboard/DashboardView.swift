//
//  DashboardView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 4/04/25.
//

import SwiftUI

struct DashboardView: View {
    @State private var showPopup = false
    @StateObject private var viewModel = DashboardViewModel(
        fetchArticlesUseCase: FetchArticlesUseCase(),
        fetchCityUseCase: FetchCityUseCase(repository: LocationRepositoryImpl()))
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                if showPopup {
                    LocationPopup(city: viewModel.city) {
                        showPopup = false
                    }
                    .transition(.scale)
                    .zIndex(1)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ImageActionButton(icon: "localrocket", width: 90, height: 90) {
                            Task {
                                await viewModel.fetchCity()
                                showPopup = true
                            }
                        }
                    }
                }
                .padding()
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
}

#Preview {
    DashboardView()
}
