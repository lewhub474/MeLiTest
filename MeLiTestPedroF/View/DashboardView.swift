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

#Preview {
    DashboardView()
}
