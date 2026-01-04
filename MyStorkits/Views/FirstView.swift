//
//  FirstView.swift
//  MyStorkits
//
//  Created by Terje Moe on 04/01/2026.
//

import SwiftUI
import StoreKit


struct FirstView: View {
    @StateObject private var model = Store()
    @State private var path: [String] = []
   var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 16) {
                if model.product != nil {
                    Button {
                        Task { await model.purchase()}
                        
                    } label: {
                        Text(model.isSubscribed ? "Paid" : "Buy")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(model.isSubscribed)
                }
                
                NavigationLink(destination: SubscriptionGroupView()) {
                    Text("Manage Subscriptions")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(destination: InAppPurcaseView()) {
                    Text("In App Purchases")
                }
                .buttonStyle(.borderedProminent)
                .disabled(model.isSubscribed)
                //.disabled(model.isPurchased)
            }
        }
    }
}

#Preview {
    FirstView()
}

