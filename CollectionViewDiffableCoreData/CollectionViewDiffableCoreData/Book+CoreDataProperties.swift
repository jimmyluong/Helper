//
//  Book+CoreDataProperties.swift
//  CollectionViewDiffableCoreData
//
//  Created by Tim on 21/5/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Book : Identifiable {

}
