//
//  SyncManager.swift
//  GoodsUpdater
//
//  Created by Nichkov_M on 20.01.2020.
//  Copyright © 2020 Utkonos. All rights reserved.
//

import Foundation

class WeakSubscribers {
    weak var subscribers: CartSubscriber?
    
    init(delegate: CartSubscriber) {
        self.subscribers = delegate
    }
}

protocol CartSubscriber: class {
    func accept(changed cart: Product)
}

protocol Product {
    var id: Int { get }
    var count: Int { get }
}

class SyncManager {

    static let shared = SyncManager()
    
    lazy var changedArray: [Goods.DisplayedItem] = []
    private lazy var subscribers: [WeakSubscribers] = []

    func add(subscriber: CartSubscriber) {
        let subscriberDelegate = WeakSubscribers.init(delegate: subscriber)
        subscribers.append(subscriberDelegate)
    }

    func addToChanged(changed: [Goods.DisplayedItem]) {
        changedArray = changed
    }
    
    func add(product: Product) {
        notifySubscribers(product)
    }

    private func notifySubscribers(_ product: Product) {
//        subscribers.forEach({ $0.accept(changed: product) })
        subscribers.forEach { (weak) in
            weak.subscribers?.accept(changed: product)
        }
    }
}
