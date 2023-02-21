//
//  AILibrariesList.swift
//  YoddChatGpt
//
//  Created by Ale on 21/02/23.
//

import SwiftUI

struct AILibrariesList: View {
    @State var library: AILibrary = OpenAIViewModel.shared.getSelectedLibrary()
    var libraries : [AILibrary] = [.OpenAISwift, .ChatGPT]
    var body: some View {
        VStack {
            List {
                Picker("Library", selection: $library) {
                    ForEach(libraries, id: \.self) { lib in
                        Text(lib.rawValue).tag(lib)
                    }
                }
            
            
                NavigationLink("OpenAISwift library", destination: AIModelTypesList())
                NavigationLink("ChatGPT library", destination: ChatGPTSwiftModelTypesList())
                
            }
            
        }.onChange(of: library) { newValue in
            OpenAIViewModel.shared.changeLibrary(AILibrary: newValue)
            print(newValue)
//            print(OpenAIViewModel.shared.selectedAILibrary)
            print(OpenAIViewModel.shared.getSelectedLibrary())
        }
        
        .onAppear {
            self.library = OpenAIViewModel.shared.getSelectedLibrary()
        }
        

    }
}


struct AILibrariesList_Previews: PreviewProvider {
    static var previews: some View {
        AILibrariesList()
    }
}
