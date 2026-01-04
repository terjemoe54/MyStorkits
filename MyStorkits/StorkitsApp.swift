//
//  MyStorkitsApp.swift
//  MyStorkits
//
//  Created by Terje Moe on 04/01/2026.
//  04.01.2026

import SwiftUI

@main
struct StorkitsApp: App {
    @StateObject private var store = Store()
    var body: some Scene {
            WindowGroup {
                   FirstView()
                   .environmentObject(store)
                   .task {
                      await store.loadProduct()
                      await store.updateSubStatus()
              }
          }
      }
  }

