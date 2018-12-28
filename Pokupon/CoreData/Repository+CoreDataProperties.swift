//
//  Repository+CoreDataProperties.swift
//  Pokupon
//
//  Created by Cat on 11/5/18.
//  Copyright © 2018 Cat. All rights reserved.
//
//

import Foundation
import CoreData

extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var language: String?
    @NSManaged public var repositoryDescription: String?
    @NSManaged public var repositoryStars: NSNumber?
    @NSManaged public var isFavorite: Bool

}
