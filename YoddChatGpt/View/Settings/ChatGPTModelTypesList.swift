//
//  ChatGPTModelTypesList.swift
//  YoddChatGpt
//
//  Created by Ale on 31/01/23.
//

import SwiftUI
import OpenAISwift


// MARK: - THIS VIEW AND THE FUNCTIONS OF OPENAIVIEWMODEL THAT USES ARE A MESS, THIS AND THE VIEWMODEL WILL HAVE HEAVY REVAMPS BUT ARE OK FOR NOW

struct ChatGPTModelTypesList: View {
    
    @State private var selection = OpenAIViewModel.shared.allModels.firstIndex { tuple in
        tuple.0.modelName == OpenAIViewModel.shared.openAiModelType.modelName
    }

    var body: some View {
        List (0..<OpenAIViewModel.shared.allModels.count, id: \.self, selection: $selection) {index in
            HStack {
                
                Text(OpenAIViewModel.shared.getOpenAIModelNameFromString(openAIModelTypeString: OpenAIViewModel.shared.allModels[index].0.modelName))
                Spacer()
                if selection == index {
                    Image(systemName: "checkmark.circle.fill")
                        .scaledToFit()
                        .foregroundColor(ThemeViewModel.shared.accentColor)
                    
                }
                
            }.onChange(of: selection) { selection in
                OpenAIViewModel.shared.setOpenAIViewModelType(openAIModelTypeString: OpenAIViewModel.shared.allModels[selection!].0.modelName)
                OpenAIViewModel.shared.setup()
            }
        }
    }
}

struct ChatGPTModelTypesList_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTModelTypesList()
    }
}


