//
//  View+extension.swift
//  YoddChatGpt
//
//  Created by Ale on 01/02/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
