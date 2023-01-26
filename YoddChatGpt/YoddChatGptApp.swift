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
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ChatView2()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
