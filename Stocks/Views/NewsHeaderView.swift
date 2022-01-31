//
//  NewsHeaderView.swift
//  Stocks
//
//  Created by Yaroslav on 30.01.22.
//

import UIKit

protocol NewsHeaderViewDelegate: AnyObject {
    func NewsHeaderViewDidButtonTapped(_ headerView: NewsHeaderView)
    
}

class NewsHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsHeaderView"
    static let preferredHeight: CGFloat = 70
    
    weak var delegate: NewsHeaderViewDelegate?
    
    struct ViewModel {
        let title: String
        let shouldShowAddButton: Bool
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("+ Watchlist", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(label, button)
        contentView.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didButtonTapped() {
        delegate?.NewsHeaderViewDidButtonTapped(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 14, y: 0, width: contentView.width - 20, height: contentView.height)
        
        button.sizeToFit()
        button.frame = CGRect(x: contentView.width - button.width - 16,
                              y: (contentView.height - button.height)/2,
                              width: button.width + 8,
                              height: button.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    public func configure(with viewModel: ViewModel) {
        label.text = viewModel.title
        button.isHidden = !viewModel.shouldShowAddButton
    }
}
