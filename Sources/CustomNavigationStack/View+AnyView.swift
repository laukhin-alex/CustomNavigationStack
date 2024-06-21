//
//  View+AnyView.swift
//
//  Created by Александр Лаухин on 20.06.23.
//

import Foundation
import SwiftUI

public extension View {
    func toAny() -> AnyView {
        return AnyView(self)
    }
}
