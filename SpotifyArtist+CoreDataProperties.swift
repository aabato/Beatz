//
//  SpotifyArtist+CoreDataProperties.swift
//  
//
//  Created by Angelica Bato on 7/13/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SpotifyArtist {

    @NSManaged var name: String?
    @NSManaged var trackByArtist: NSSet?

}
