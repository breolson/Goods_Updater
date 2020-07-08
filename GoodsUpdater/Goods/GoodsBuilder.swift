//
//  GoodsBuilder.swift
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

enum GoodsBuilder {
    
    static func build(sort: Goods.SortType) -> GoodsViewController {
        let viewController = configureModule(sort: sort)
        viewController.title = sort.title
        return viewController
    }
    
    private static func configureModule(sort: Goods.SortType) -> GoodsViewController {
        let viewController = GoodsViewController()
        let interactor = GoodsInteractor(sort: sort)
        let presenter = GoodsPresenter()
        let router = GoodsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
    
}
