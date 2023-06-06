//
//  Drawing_Pencil_KitApp.swift
//  Drawing Pencil Kit
//
//  Created by Silvia Pasica on 06/06/23.
//

import SwiftUI

@main
struct Drawing_Pencil_KitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
