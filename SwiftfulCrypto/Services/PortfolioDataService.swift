//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by David J on 5/26/25.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores{ (_, error) in
            if let error = error {
                print("[‼️] Error loading CoreData: \(error)")
            }
        }
        
        self.getPortfolio()
    }
    
    // MARK: - PUBLIC
    
    func updatePortfolio(_ coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity, amount: amount)
            } else {
                remove(entity)
            }
        } else {
            addCoin(coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("[❗]Error fetching Portfolio Entities: \(error)")
        }
    }
    
    private func addCoin(_ coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        
        entity.coinID = coin.id
        entity.amount = amount
        
        push()
    }
    
    private func commit() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("[‼️] Error saving to CoreData: \(error)")
        }
    }
    
    private func push() {
        commit()
        getPortfolio()
    }
    
    private func update(_ entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        
    }
    
    private func remove(_ entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        push()
    }
    
}
