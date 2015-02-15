//
//  OwnedRecordsNS.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/15/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import Foundation
import CoreData

class OwnedRecordsNS: NSManagedObject {

    @NSManaged var album: String
    @NSManaged var artist: String


class func createInManagedObjectContext(moc: NSManagedObjectContext, artist: String, album: String) -> OwnedRecordsNS {
    let newItem = NSEntityDescription.insertNewObjectForEntityForName("OwnedRecordsNS", inManagedObjectContext: moc) as OwnedRecordsNS
    newItem.artist = artist
    newItem.album = album
    
    return newItem
    }
}