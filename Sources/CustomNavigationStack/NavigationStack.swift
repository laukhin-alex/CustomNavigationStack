//
//  NavigationStack.swift
//
//  Created by Александр Лаухин on 20.06.23.
//

import Foundation
import SwiftUI

public struct NavigationStack {
    private var screens: [ScreenModel] = [ScreenModel]()
    
    var count: Int {
        screens.count
    }
    
    func top() -> ScreenModel? {
        return self.screens.last
    }
    
    mutating func push(_ screen: ScreenModel) {
        self.screens.append(screen)
    }
    
    mutating func pop() {
        _ = self.screens.popLast()
    }
    
    mutating func popToRoot(customStartScreen: Bool) {
        if customStartScreen {
            self.screens.removeLast(count - 1)
        } else {
            self.screens.removeLast(count)
        }
    }
}
