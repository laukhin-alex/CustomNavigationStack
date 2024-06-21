//
//  CustomNavigationContainer.swift
//
//  Created by Александр Лаухин on 20.06.23.
//

import SwiftUI

public protocol CustomNavigation: View {
    var navigationManager: CustomNavigationContainer? { get set }
}

public protocol CustomNavigationContainer {
    func push<Content: View & CustomNavigation>(view: Content)
    func pop()
    func popToRoot()
}

public struct NavigationContainer<Content: View & CustomNavigation>: View, CustomNavigationContainer {
    @ObservedObject var navigationViewModel: NavigationViewModel
    public var customStartScreen: Bool
    private var content: Content
    
    public init(viewModel: NavigationViewModel, customStartScreen: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.navigationViewModel = viewModel
        self.content = content()
        self.customStartScreen = customStartScreen
        self.content.navigationManager = self
    }
    
    public var body: some View {
        let isRoot = navigationViewModel.currentScreen == nil
        ZStack {
            if isRoot {
                content
            } else {
                navigationViewModel.currentScreen?.screen
                    .transition(transitionForDirection(navigationViewModel.animationDirection))
            }
        }
        .animation(.easeIn, value: navigationViewModel.currentScreen)
    }
    
    private func transitionForDirection(_ direction: AnimationDirection) -> AnyTransition {
        switch direction {
        case .forward:
            return .move(edge: .leading).combined(with: .opacity.combined(with: .opacity))
        case .backward:
            return .move(edge: .trailing).combined(with: .opacity)
        case .none:
            return .move(edge: .leading).combined(with: .opacity)
        }
    }

    public func push<NewContent>(view: NewContent) where NewContent: CustomNavigation {
        var newView = view
        newView.navigationManager = self
        self.navigationViewModel.push(newView.toAny())
    }
    
    public func pop() {
        self.navigationViewModel.pop()
    }
    
    public func popToRoot() {
        self.navigationViewModel.popToRoot(customStartScreen: customStartScreen)
    }
}
