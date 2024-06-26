# CustomNavigationStack

A Swift package providing a custom navigation stack for SwiftUI applications. This package helps in managing the navigation flow in a SwiftUI application using a custom stack-based approach.

## Requirements

- iOS 13.0+
- Swift 5.3+

## Installation with Swift Package Manager (Xcode 11+)

[Swift Package Manager](https://swift.org/package-manager/) (SwiftPM)

### Step-by-Step Guide:

1. Open your project in Xcode.
2. Go to `File -> Swift Packages -> Add Package Dependency`.
3. Enter the repository URL: `https://github.com/laukhin-alex/CustomNavigationStack.git` or type `CustomNavigationStack` to search.
4. Select the package and choose the dependency type (tagged version, branch, or commit). Then Xcode will set up everything for you.

### Manual Package.swift Configuration

If you want to add `CustomNavigationStack` to your own framework or use `CustomNavigationStack` as a dependency, update your `Package.swift` file:

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YourProjectName",
    dependencies: [
        .package(url: "https://github.com/laukhin-alex/CustomNavigationStack.git", from: "1.0.2")
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: ["CustomNavigationStack"]),
        // Other targets...
    ]
)

## Usage

### Importing the Package

```swift
import CustomNavigationStack
```

### Setting Up the Navigation

To set up the navigation stack, follow these steps:

 **1. Define your views conforming to CustomNavigation.**

```swift    
import SwiftUI
import CustomNavigationStack

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
```
**2. Implement your RootView.
  
*in case you have animated or special launch screen
  
```swift   
import SwiftUI
import CustomNavigationStack

struct RootView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?
    
    var body: some View {
        VStack {
            LaunchScreen() //mark: you can put here your loadingscreen
        }
        .task {
            await delayAndNavigate()
        }
    }
    private func delayAndNavigate() async {
        do {
            try await Task.sleep(nanoseconds: 3_000_000_000) // 3 sec, you can add more
            await MainActor.run {
                //MARK: for sure of updating UI in Main thread
                navigationManager?.push(view: 
                    FirstView(navigationManager: navigationManager)
                    )
            }
        } catch {
            // error handler
            print("Task was cancelled or failed")
        }
    }
}
```

*in case you don't
  
```swift   
import SwiftUI
import CustomNavigationStack

struct RootView: View, CustomNavigation {
    var navigationManager: CustomNavigationContainer?
    
    var body: some View {
        VStack {
           FirstView(navigationManager: navigationManager)
        }
}
```
**3. Set up the main app entry point.

```swift 
import SwiftUI

@main
struct YourApp: App {
    @StateObject var navigationViewModel = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationContainer(viewModel: navigationViewModel,
                                customStartScreen: true) { //mark: false if you don't have customStartScreen
                RootView()
            }
        }
    }
}
```

## License

CustomNavigationStack is released for free.

## Author

Created by Aleksandr Laukhin. 
- Email: alex.laukhin.pe@gmail.com
- LinkedIn: [Alexander Laukhin](https://www.linkedin.com/in/alexander-laukhin)
