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
        fetchCityUseCase: FetchCityUseCase(
            repository: DefaultLocationRepository()
        )
    )
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        } else if !viewModel.articles.isEmpty {
            ScrollView {
                ArticleListView(articles: viewModel.articles)
            }
            .scrollDismissesKeyboard(.interactively)
            .cornerRadius(5)
        } else {
            Spacer()
            Text("No se encontraron artículos.")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    @ViewBuilder
    var popupView: some View {
        if showPopup {
            LocationPopup(city: viewModel.city) {
                showPopup = false
            }
            .transition(.scale)
            .zIndex(1)
        }
    }
    
    @ViewBuilder
    var floatBottomButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ImageActionButton(icon: "localrocket", size: 90) {
                    Task {
                        await viewModel.fetchCity()
                        showPopup = true
                    }
                }
            }
        }
        .padding()
    }
    
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
                        
                        contentView
                    }
                }
                .padding(.horizontal, 10)
                
                popupView
                
                floatBottomButton
            }
            .onAppear {
                Task {
                    await viewModel.fetchArticles()
                }
            }
            .alert("Error", isPresented: $viewModel.isPresentingError, actions: {
                Button("OK") {
                    viewModel.dismissError()
                }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
            .onChange(of: viewModel.searchText) { _ in
                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000) // debounce de 0.5s
                    await viewModel.fetchArticles()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
