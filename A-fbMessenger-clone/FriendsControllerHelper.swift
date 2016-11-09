//
//  FriendsController.swift
//  A-fbMessenger-clone
//
//  Created by SimpuMind on 11/7/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController{
    
    func setupData(){
        
        clearData()
        
        let context = getContext()
            
           
        //createMarkMessage()
        createSteveMessage()
        
        
        let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        donald.name = "Donald Trump"
        donald.profileImageName = "donald_trump_profile"
        FriendsController.createMessageWithText(text: "You are fired!", friend: donald, minuteAgo: 5, context: context)
        
        let gandi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        gandi.name = "Mahatma Gandhi"
        gandi.profileImageName = "gandhi"
        FriendsController.createMessageWithText(text: "Love, Peace and Joy", friend: gandi, minuteAgo: 60 * 24, context: context)
        
        let hilary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        hilary.name = "Hillary Clinton"
        hilary.profileImageName = "hillary_profile"
        FriendsController.createMessageWithText(text: "Love, Peace and Joy", friend: hilary, minuteAgo: 8 * 60 * 24, context: context)
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    fileprivate func createSteveMessage(){
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: getContext()) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
    
    FriendsController.createMessageWithText(text: "Good morning..", friend: steve, minuteAgo: 3, context: getContext())
    
    FriendsController.createMessageWithText(text: "Hello, how are you, hope you are having a good morning!?", friend: steve, minuteAgo: 2, context: getContext())
    
    FriendsController.createMessageWithText(text: "Are you interested in buying an Apple device? We have a variety of Apple devices that sooths your need.", friend: steve, minuteAgo: 1, context: getContext())
        
        FriendsController.createMessageWithText(text: "Yes, totally looking to buy an iPhone 7.", friend: steve, minuteAgo: 1, context: getContext(), isSender: true)
        
        FriendsController.createMessageWithText(text: "Totally understand that you want the new iPhone 7, but you have to wait till September for the new release. Sorry that's how Apple like to do things.", friend: steve, minuteAgo: 1, context: getContext())
        
        FriendsController.createMessageWithText(text: "Absolutely, i will just use my gigantic iPhone 6 Plus until then!!!", friend: steve, minuteAgo: 1, context: getContext(), isSender: true)
    }
    
    
    
    static func createMessageWithText(text: String, friend: Friend, minuteAgo: Double,
                                           context: NSManagedObjectContext, isSender: Bool = false){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minuteAgo * 60)
        message.isSender = NSNumber(value: isSender) as Bool
        friend.lastMessage = message

    }
    
//    func loadData(){
//        
//        messages = [Message]()
//        
//        if let friends = fetchFriends(){
//        
//            for friend in friends{
//            
//                let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
//                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                fetchRequest.fetchLimit = 1
//                do{
//                
//                    let fetchMessages = try getContext().fetch(fetchRequest)
//                    messages?.append(contentsOf: fetchMessages)
//                }catch {
//                    print("Error with request: \(error)")
//                }
//            }
//            
//             messages?.sort(by: { $0.date?.compare($1.date as! Date) == .orderedDescending })
//        }
//    }
//    
//    fileprivate func fetchFriends() -> [Friend]? {
//        
//        let fetchRequest: NSFetchRequest<Friend> = Friend.fetchRequest()
//        do{
//            return try getContext().fetch(fetchRequest)
//        }catch {
//            print("Error with request: \(error)")
//        }
//        return nil
//    }
    
    func clearData(){
        do{
            
            let entityNames = ["Message", "Friend"]
            for entity in entityNames{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                let request = try (getContext().fetch(fetchRequest)) as? [NSManagedObject]
                for object in request! {
                    getContext().delete(object)
                }
            }
            try(getContext().save())
        }catch let err{
            print(err)
        }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
