//
//  DataController.swift
//  YoddChatGpt
//
//  Created by Ale on 26/01/23.
//

import Foundation
import CoreData

//Multiple NSEntityDescriptions claim the NSManagedObject subclass 'Message' so +entity is unable to disambiguate
class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "MessageModel")

    static let shared = DataController()
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("ERROR >>> Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
//            print("Data saved")
        } catch {
            print("ERROR >>> Data couldn't be saved")
        }
    }
    
    
    func addMessage (body : String, sender: String, type : String, context : NSManagedObjectContext) {
        let message = Message(context: context)
        message.date = Date()
        message.body = body
        message.id = UUID()
        message.sender = sender
        message.type = type
        message.saved = false
        message.chatModel = OpenAIViewModel.shared.getOpenAIModelNameFromString(openAIModelTypeString: OpenAIViewModel.shared.openAiModelType.modelName)
        save(context: context)
    }
    
    func saveMessage (message: Message, context : NSManagedObjectContext) {
        if message.saved == false {
            message.saved = true
        } else {
            message.saved = false
        }
        save(context: context)
    }

    
    func deleteData (context : NSManagedObjectContext, message : Message) {
            context.delete(message)
    }
    
    func deleteAllData (context : NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            print(error)
            // TODO: handle the error
        }
    }
    
    func deleteAllUnsavedData (context : NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
        fetchRequest.predicate = NSPredicate(format: "saved == %@", "\(false)")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: deleteRequest)
        } catch let error as NSError {
            print(error)
            // TODO: handle the error

        }
    }

    
}
