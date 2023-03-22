//
//  ViperSwifttUIApp.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import SwiftUI

@main
struct ViperSwifttUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
