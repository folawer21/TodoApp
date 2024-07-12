//
//  Extension.isShown.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func isShown(shown: Bool) -> some View {
        if shown {
            withAnimation(.default) {
                self
            }
        } else {
            withAnimation(.default) {
                self.hidden()
            }
        }
    }
}
