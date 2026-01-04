//
//  SubView.swift
//  MyStorkits
//
//  Created by Terje Moe on 04/01/2026.
//


import SwiftUI
import StoreKit


struct InAppPurcaseView: View {
    @StateObject private var model = Store()
    var body: some View {
        Text(model.isSubscribed ? "\(model.product!.displayName)" : "Not Subbed")
            .font(.title)
        if let product = model.product {
        Button {
            Task { await model.purchase()}
                
                } label: {
                    Text(model.isSubscribed ? "Subbed" : "Subbed for \(product.displayPrice)")
                }
                .buttonStyle(.borderedProminent)
                .disabled(model.isSubscribed)
         }
    }
}


#Preview {
    InAppPurcaseView()
}
