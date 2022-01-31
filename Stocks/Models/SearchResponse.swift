//
//  SearchResponse.swift
//  Stocks
//
//  Created by Yaroslav on 27.01.22.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
