//
//  CreateChatStamps.swift
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
func createBotTimeStamp (date : Date) -> some View {
    Text(date, style: .time)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.leading)
}

func createUserTimeStamp (date : Date) -> some View {
    Text(date, style: .time)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.trailing)
}


@ViewBuilder
func createFullTimeStamp (date : Date) -> some View {
    Text(date, style: .date)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.leading, 3)
}

func createModelTypeStamp(modelType : String) -> some View {
    Text(modelType)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.leading, 3)
}

