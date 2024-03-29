//
//  Todo+CoreDataProperties.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/26/24.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }
    @NSManaged public var pkey: UUID?
    @NSManaged public var memoTitle: String?
    @NSManaged public var memoContent: String?
    @NSManaged public var date: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var complete: Bool

}

extension Todo : Identifiable {

}
