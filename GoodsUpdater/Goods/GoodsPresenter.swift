//
//  GoodsPresenter.swift
//  GoodsUpdater
//
//  Created by Александр on 14.01.2020.
//  Copyright (c) 2020 Utkonos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GoodsPresentationLogic {
    func presentFetchingResult(response: Goods.Fetching.Response)
    func presentActual(response: Goods.UpdateItem.Response)
}

class GoodsPresenter: GoodsPresentationLogic {
    weak var viewController: GoodsDisplayLogic?
    
    // MARK: - GoodsPresentationLogic
    
    func presentFetchingResult(response: Goods.Fetching.Response) {
        var displayedItems = response.items.compactMap { configureDisplayedItem($0) }
        if !(SyncManager.shared.changedArray.isEmpty) {
            displayedItems = SyncManager.shared.changedArray
        }
        let viewModel = Goods.Fetching.ViewModel(displayedItems: displayedItems)
        viewController?.displayFetchingResult(viewModel: viewModel)
    }
    
    func presentActual(response: Goods.UpdateItem.Response) {
        var items = response.items
        let item = response.item
        var index: Int = 0
        for each in 0..<items.count {
            if items[each].id == item.id {
                items[each].count = item.count
                index = each
                break
            }
        }
        
        let viewModel = Goods.UpdateItem.ViewModel(index: index, displayedItems: items)
        viewController?.reloadRow(viewModel: viewModel)
    }
    
    // MARK: - Private methods
    
    private func configureDisplayedItem(_ item: Item) -> Goods.DisplayedItem? {
        guard let image = UIImage(named: item.image) else { return nil }

        let item = Goods.DisplayedItem(id: item.id, image: image, title: item.name, count: item.count)
        return item
    }
}
