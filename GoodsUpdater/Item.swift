//
//  Item.swift
//  GoodsUpdater
//
//  Created by Александр on 14.01.2020.
//  Copyright © 2020 Utkonos. All rights reserved.
//

import Foundation

struct Item: Codable {
    var id: Int
    var name: String
    var image: String
    var rating: Double
    var count: Int
}

struct Edited: Product {
    var id : Int
    var count: Int
}
