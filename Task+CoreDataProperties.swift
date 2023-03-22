//
//  Task+CoreDataProperties.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var timestamp: Date
    @NSManaged public var body: String
    @NSManaged public var title: String
    @NSManaged public var id: UUID

}

extension Task : Identifiable {

}
