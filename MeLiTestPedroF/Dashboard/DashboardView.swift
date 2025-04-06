//
//  DashboardView.swift
//  MeLiTestPedroF
//
//  Created by Macky on 4/04/25.
//

import SwiftUI

//struct DashboardView: View {
//    @StateObject private var viewModel = DashboardViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            BackgroundView {
//                VStack(spacing: 16) {
//                    SearchBar(
//                        text: $viewModel.searchText,
//                        onSearch: {
//                            Task {
//                                await viewModel.fetchArticles()
//                            }
//                        }
//                    )
//                    if viewModel.isLoading {
//                        ProgressView()
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    } else if viewModel.showEmptyState {
//                        Spacer()
//                        Text("No se encontraron artículos.")
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                        Spacer()
//                    } else if viewModel.showArticleList {
//                        ScrollView {
//                            ArticleListView(articles: viewModel.articles)
//                        }
//                        .scrollDismissesKeyboard(.interactively)
//                        .cornerRadius(5)
//                    }
//                }
//                .onAppear {
//                    Task {
//                        await viewModel.fetchArticles()
//                    }
//                }
//            }
//            .padding(.horizontal, 10)
//        }
//        .alert("Error", isPresented: viewModel.isPresentingError, actions: {
//            Button("OK") {
//                viewModel.dismissError()
//            }
//        }, message: {
//            Text(viewModel.errorMessage ?? "")
//        })
//    }
//}

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var showPopup = false

    var body: some View {
        ZStack {
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

            // Popup de ciudad
            if showPopup {
                LocationPopup(city: locationManager.city) {
                    showPopup = false
                }
                .transition(.scale)
                .zIndex(1)
            }

            // Botón flotante
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ImageActionButton(icon: "localrocket2", width: 90, height: 90) {
                        locationManager.startLocationRetryLoop()
                        showPopup = true
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    DashboardView()
}
