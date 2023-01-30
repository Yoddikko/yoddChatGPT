//
//  TimeStamp.swift
//  YoddChatGpt
//
//  Created by Ale on 27/01/23.
//

import Foundation
import SwiftUI

/**
 This is the viewbuilder that creates the message timestamp.

 - Version: 0.1

 */
@ViewBuilder
func createTimeStamp (date : Date) -> some View {
    Text(date, style: .time)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.horizontal)
}
