//
//  ContentView.swift
//  CustomNavigationExampleApp
//
//  Created by Александр Лаухин on 21.06.2024.
//

import SwiftUI
import CustomNavigationStack

struct ContentView: View, CustomNavigation{
    var navigationManager: CustomNavigationContainer?
    
    var body: some View {
      
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Launch screen")
        }
        .padding()
    }
}

struct RootView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?
    
    var body: some View {
        VStack {
            ContentView() //mark: you can put here your loadingscreen
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                navigationManager?.push(view:
                    FirstView(navigationManager: navigationManager)
                    )
            }
        }
    }
}

struct FirstView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?

    var body: some View {
        VStack {
            Text("First View")
            Button(action: {
                navigationManager?.push(view: SecondView(navigationManager: navigationManager))
            }) {
                Text("Go to Second View")
            }
        }
    }
}

struct SecondView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?
    
    var body: some View {
        VStack {
            Text("Second View")
            Button(action: {
                navigationManager?.push(view: ThirdView(navigationManager: navigationManager))
            }) {
                Text("Go to third View")
            }
            Button(action: {
                navigationManager?.popToRoot()
            }) {
                Text("Back to Root View")
            }
        }
    }
}

struct ThirdView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?

    var body: some View {
        VStack {
            Text("Third View")
            Button(action: {
                navigationManager?.pop()
            }) {
                Text("Back to second View")
            }
            Button(action: {
                navigationManager?.popToRoot()
            }) {
                Text("Back to Root View")
            }
        }
    }
}
#Preview {
    ContentView()
}

