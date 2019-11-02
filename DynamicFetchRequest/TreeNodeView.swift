//
//  TreeNodeView.swift
//  DynamicFetchRequest
//
//  Created by SchwiftyUI on 9/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI
import CoreData

struct TreeNodeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    var root: TreeNode?
    var fetchRequest: FetchRequest<TreeNode>
    var fetchedResults: FetchedResults<TreeNode> {
        fetchRequest.wrappedValue
    }
    
    init(root: TreeNode? = nil) {
        self.root = root
        fetchRequest = FetchRequest(fetchRequest: TreeNode.getNodes(root: root))
        print("Init called for TreeNodeView(\(root?.name ?? "root"))")
    }
    
    var body: some View {
        VStack {
            if self.root != nil {
                NavigationLink(destination: EditNode(node: self.root!)) {
                    Text("Edit Node Name")
                }
            }
            List {
                ForEach(fetchedResults, id: \.self) { node in
                    NavigationLink(destination: TreeNodeWrapperView(root: node)) {
                        Text("\(node.name)")
                    }
                }
                .onDelete(perform: deleteItem)
            }
            Button(action: addItem) {
                Text("Add Item")
            }
        }
        .navigationBarItems(trailing: EditButton())
    }
    
    func deleteItem(indexSet: IndexSet) {
        let node = fetchedResults[indexSet.first!]
        managedObjectContext.delete(node)
        saveItems()
    }
    
    func addItem() {
        let node = TreeNode(context: managedObjectContext)
        
        if root != nil {
            node.name = "\(root!.name):\(fetchedResults.count + 1)"
        } else {
            node.name = "\(fetchedResults.count + 1)"
        }
        
        node.parent = root
        saveItems()
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct TreeNodeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeNodeView()
    }
}
