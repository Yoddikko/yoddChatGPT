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
    
    // MARK: - AppStorage
    @AppStorage ("shouldShowOnBoarding") var shouldShowOnBoarding : Bool = true
    

    
    var body: some Scene {
        WindowGroup {
            if shouldShowOnBoarding {
                TabView {
                    OnBoarding1()
                    OnBoarding2()

//                    OnBoardingView(shouldShowOnBoarding: $shouldShowOnBoarding)
                }.tabViewStyle(.page(indexDisplayMode: .always))

            } else {
                ChatView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .accentColor(accentColor.accentColor)
            }
        }

        
    }
}
