//
//  ItemTableViewCell.swift
//  GoodsUpdater
//
//  Created by Александр on 14.01.2020.
//  Copyright © 2020 Utkonos. All rights reserved.
//

import UIKit
import Reusable

protocol ItemTableViewCellDelegate: class {
    func itemTableViewCell(_ cell: ItemTableViewCell, didChangeItem id: Int, count: Int)
}

class ItemTableViewCell: UITableViewCell, Reusable {
    
    weak var delegate: ItemTableViewCellDelegate?
    
    private var itemID: Int?
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = tintColor
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = tintColor
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.systemBackground
        
        minusButton.addTarget(self, action: #selector(self.minusButtonTapped(_:)), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(self.plusButtonTapped(_:)), for: .touchUpInside)
        
        initialLayout()
    }
    
    private func initialLayout() {
        contentView.addSubview(itemImageView)
        itemImageView.size(CGSize(width: 100, height: 100))
        itemImageView.edges(to: contentView, excluding: .right, insets: .uniform(16))
        
        contentView.addSubview(titleLabel)
        titleLabel.top(to: contentView, offset: 24)
        titleLabel.leadingToTrailing(of: itemImageView, offset: 16)
        titleLabel.trailing(to: contentView, offset: -16)
        
        contentView.addSubview(minusButton)
        minusButton.bottom(to: contentView, offset: -24)
        minusButton.leadingToTrailing(of: itemImageView, offset: 16)
        minusButton.size(CGSize(width: 32, height: 32))
        
        contentView.addSubview(countLabel)
        countLabel.bottom(to: contentView, offset: -24)
        countLabel.leadingToTrailing(of: minusButton)
        countLabel.size(CGSize(width: 32, height: 32))
        
        contentView.addSubview(plusButton)
        plusButton.bottom(to: contentView, offset: -24)
        plusButton.leadingToTrailing(of: countLabel)
        plusButton.size(CGSize(width: 32, height: 32))
    }
    
    func configureItem(_ item: Goods.DisplayedItem) {
        itemID = item.id
        itemImageView.image = item.image
        titleLabel.text = item.title
        countLabel.text = "\(item.count)"
    }
    
    @objc private func minusButtonTapped(_ sender: UIButton) {
        changeCount(on: -1)
    }
    
    @objc private func plusButtonTapped(_ sender: UIButton) {
        changeCount(on: 1)
    }
    
    private func changeCount(on change: Int) {
        if let count = Int(countLabel.text ?? "") {
            let newCount = max(0, count + change)
            countLabel.text = "\(newCount)"
            
            if let id = itemID {
                delegate?.itemTableViewCell(self, didChangeItem: id, count: newCount)
            }
            
        }
    }
    
}
