//
//  CustomNavigationExampleAppApp.swift
//  CustomNavigationExampleApp
//
//  Created by Александр Лаухин on 21.06.2024.
//

import SwiftUI
import CustomNavigationStack

@main
struct CustomNavigationExampleAppApp: App {
    @StateObject var navigationViewModel = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationContainer(viewModel: navigationViewModel, customStartScreen: true) {
                RootView()
            }
        }
    }
}
