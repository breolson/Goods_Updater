//
//  GoodsModels.swift
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

enum Goods {
    
    struct DisplayedItem {
        var id: Int
        var image: UIImage
        var title: String
        var count: Int
    }
    
    enum SortType {
        case popular
        case new
        
        var title: String {
            switch self {
            case .popular:
                return "Популярные"
            case .new:
                return "Новинки"
            }
        }
    }
    
    // MARK: Use cases
    
    enum Fetching {
        struct Request {
        }
        struct Response {
            var items: [Item]
        }
        struct ViewModel {
            var displayedItems: [DisplayedItem]
        }
    }
    
    enum UpdateItem {
        struct Request {
            var item: Product
            var items: [DisplayedItem]
        }
        struct Response {
            var item: Product
            var items: [DisplayedItem]
        }
        struct ViewModel {
            var index: Int
            var displayedItems: [DisplayedItem]
        }
    }
}
