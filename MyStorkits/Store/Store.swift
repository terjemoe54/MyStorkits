//
//  Store.swift
//  MyStorkits
//
//  Created by Terje Moe on 04/01/2026.
//
//  SubViewModel.swift
//  StorkitDemo
//
//  Created by Terje Moe on 03/01/2026.

import SwiftUI
import StoreKit
import Combine

@MainActor
final class Store: ObservableObject {
    private var updatesListener: Task<Void, Never>? = nil
    private let SubProductIdentifier = "com.terjemoe.premium"
   // private let SubProductIdentifier = "com.terjemoe.limited"
   // private let SubProductIdentifier = "com.terjemoe.annual"
    @Published var product: Product?
    @Published var isSubscribed = false
    @Published var isPurchased = false
    
    init() {
        Task {
            await loadProduct()
            await updateSubStatus()
        }
        updatesListener = listenForTransaction()
    }

    func loadProduct() async {
        if let loaded = try? await Product.products(for: [SubProductIdentifier]).first {
            product = loaded
        }
    }
    
    func purchase() async {
        guard let product else { return }
        
        if case .success(let result) = try? await product.purchase(),
           case .verified(let transaction) = result {
            await transaction.finish()
            await updateSubStatus()
            
        }
            
    }
    
    func updateSubStatus() async {
        if let result = await Transaction.latest(for: SubProductIdentifier),
           case .verified(let transaction) = result {
            let active = (transaction.revocationDate == nil) &&
            (transaction.expirationDate.map{ $0 > Date()} ?? true)
            isSubscribed = active
        } else {
            isSubscribed = false
        }
    }
    
    @discardableResult
    private func listenForTransaction() -> Task<Void, Never> {
        Task { @MainActor in
            for await update in Transaction.updates {
                if case .verified(let transaction) = update,
                   transaction.productID == SubProductIdentifier {
                    await transaction.finish()
                    await updateSubStatus()
                }
            }
        }
    }
    
    deinit {
        updatesListener?.cancel()
    }
}
