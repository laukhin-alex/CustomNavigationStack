//
//  ScreenModel.swift
//
//  Created by Александр Лаухин on 20.06.23.
//

import Foundation
import SwiftUI

public struct ScreenModel: Identifiable, Equatable {
    public static func == (lhs: ScreenModel, rhs: ScreenModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id: String = UUID().uuidString
    public let screen: AnyView
}
