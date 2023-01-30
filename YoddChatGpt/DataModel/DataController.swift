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
    
    
    func addMessage (body : String, sender: String, type : String, context : NSManagedObjectContext) {
        let message = Message(context: context)
        message.date = Date()
        message.body = body
        message.id = UUID()
        message.sender = sender == "bot" ? "bot" : "user"
        message.type = type == "text" ? "text" : "error"
        save(context: context)
    }
    
    func deleteData (context : NSManagedObjectContext, message : Message) {
        do {
            try context.delete(message)
        } catch {
            print("Couldn't delete item")
        }
    }
    
    func deleteAllData (context : NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Message")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeAndMergeChanges(using: deleteRequest)
//            try context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
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
