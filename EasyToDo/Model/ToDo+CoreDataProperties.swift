//
//  ToDo+CoreDataProperties.swift
//  EasyToDo
//
//  Created by Han Dole Kim on 5/7/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String?
    @NSManaged public var checked: Bool

}
