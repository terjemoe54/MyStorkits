//
//  ContentView.swift
//  MyStorkits
//
//  Created by Terje Moe on 04/01/2026.
//  Groupcode for Sub: 8CB19271

import StoreKit
import SwiftUI

struct SubscriptionGroupView: View {
    @StateObject private var model = Store()
    @State private var showSubscriptionStore: Bool = false
    var body: some View {
        Button {
            showSubscriptionStore.toggle()
        } label: {
            Text("Manage Subscriptions")
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showSubscriptionStore) {
            SubscriptionStoreView(groupID: "8CB19271")
        }
    }
}

#Preview {
    SubscriptionGroupView()
}
