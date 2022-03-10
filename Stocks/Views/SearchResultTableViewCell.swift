//
//  SearchResultTableViewCell.swift
//  Stocks
//
//  Created by Yaroslav on 24.01.22.
//

import UIKit

/// TableView cell for search result
final class SearchResultTableViewCell: UITableViewCell {
    /// Identifier for cell
    static let identifier = "SearchResultTableViewCell"
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
