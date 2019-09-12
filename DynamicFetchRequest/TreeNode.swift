//
//  TreeNode.swift
//  DynamicFetchRequest
//
//  Created by SchwiftyUI on 9/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import CoreData

class TreeNode: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var children: NSSet?
    @NSManaged var parent: TreeNode?
}

extension TreeNode {
    static func getNodes(root: TreeNode?) -> NSFetchRequest<TreeNode> {
        let request = TreeNode.fetchRequest() as! NSFetchRequest<TreeNode>
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate(format: "parent = %@", root ?? NSNull())
        return request
    }
}
