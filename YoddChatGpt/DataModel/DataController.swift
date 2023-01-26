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
            print("Data saved")
        } catch {
            print("ERROR >>> Data couldn't be saved")
        }
    }
    
    
    func addMessage (body : String, sender: String, context : NSManagedObjectContext) {
        let message = Message(context: context)
        message.date = Date()
        message.body = body
        message.id = UUID()
        message.sender = sender == "bot" ? "bot" : "user"
        
        save(context: context)
    }
    
//    func editMessage (message: Message, body : String, sender : Sender, id : UUID, context : NSManagedObjectContext) {
//        message.timestamp = Date()
//        message.body = body
//        message.id = UUID()
//        message.sender = sender == .bot ? "bot" : "user"
//
//        save(context: context)
//    }
}
