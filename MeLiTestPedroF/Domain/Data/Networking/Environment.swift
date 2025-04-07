//
//  Environment.swift
//  MeLiTest
//
//  Created by Ronald Ivan Ruiz Poveda on 5/04/25.
//

import Foundation

enum Environment {
    case development
    
    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://api.spaceflightnewsapi.net/v4/")!
        }
    }
}
