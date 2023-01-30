//
//  YoddChatGptApp.swift
//  YoddChatGpt
//
//  Created by Ale on 17/01/23.
//

import SwiftUI

@main
struct YoddChatGptApp: App {
    @StateObject private var dataController = DataController.shared
    @ObservedObject var accentColor = ThemeViewModel.shared
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChatView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .accentColor(accentColor.accentColor)
        }
    }
}
