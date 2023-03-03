/*
The MIT License (MIT)

 Copyright (c) 2023 Alessio Iodice

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  DataController.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.
//

import Foundation
import CoreData

//Multiple NSEntityDescriptions claim the NSManagedObject subclass 'Message' so +entity is unable to disambiguate
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MessageModel")

    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                // swiftlint:disable:next no_direct_standard_out_logs
                print("ERROR >>> Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
//            print("Data saved")
        } catch {
//            print("ERROR >>> Data couldn't be saved")
        }
    }
    
    func addMessage (body: String, sender: String, type: String, aiLibrary: AILibrary? = .none, outputType: OutputType, context: NSManagedObjectContext) {
        let message = Message(context: context)
        message.date = Date()
        message.body = body
        message.id = UUID()
        message.sender = sender
        message.type = type
        message.saved = false
        if outputType == .text {
            if aiLibrary == .OpenAISwift {
                message.chatModel = AIChatViewModel.shared.getOpenAIModelNameFromString(openAIModelTypeString: AIChatViewModel.shared.openAIModelType.modelName)
            }
            if aiLibrary == .ChatGPT {
                message.chatModel = "ChatGPT"
            }
        }
        if outputType == .image {
            message.chatModel = "Dall-E"
        }
        save(context: context)
    }
    
    func saveMessage (message: Message, context: NSManagedObjectContext) {
        if message.saved == false {
            message.saved = true
        } else {
            message.saved = false
        }
        save(context: context)
    }

    func deleteData (context: NSManagedObjectContext, message: Message) {
            context.delete(message)
    }
    
    func deleteAllData (context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            // swiftlint:disable:next no_direct_standard_out_logs
            print(error)
            // TODO: handle the error
        }
    }
    
    func deleteAllUnsavedData (context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
        fetchRequest.predicate = NSPredicate(format: "saved == %@", "\(false)")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            // swiftlint:disable:next no_direct_standard_out_logs
            print(error)
            // TODO: handle the error
        }
    }
}
