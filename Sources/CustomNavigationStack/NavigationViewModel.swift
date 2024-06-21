//
//  NavigationViewModel.swift
//
//  Created by Александр Лаухин on 20.06.23.
//

import Foundation
import SwiftUI

public enum NavigationType {
    case pop, push, popToRoot
}

public enum AnimationDirection {
    case none
    case forward
    case backward
}

public class NavigationViewModel: ObservableObject {
    @Published var currentScreen: ScreenModel? = nil
    @Published var animationDirection: AnimationDirection = .none
    @Published var isRootView: Bool = true
    var navigationType: NavigationType = .push
    var screenStack: NavigationStack = NavigationStack() {
        didSet {
            withAnimation {
                currentScreen = screenStack.top()
            }
        }
    }
    
    public init() {}
    
    public func push(_ screenView: AnyView) {
        self.navigationType = .push
        self.animationDirection = .forward
        let screen = ScreenModel(screen: screenView)
        self.screenStack.push(screen)
        self.isRootView = self.screenStack.count == 0
    }
    
    public func pop() {
        self.navigationType = .pop
        self.animationDirection = .backward
        self.screenStack.pop()
        self.isRootView = self.screenStack.count == 0
    }
    
    public func popToRoot(customStartScreen: Bool) {
        self.navigationType = .popToRoot
        self.animationDirection = .backward
        self.screenStack.popToRoot(customStartScreen: customStartScreen)
        self.isRootView = true
    }
}
