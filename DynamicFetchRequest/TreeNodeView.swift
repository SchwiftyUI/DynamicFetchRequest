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
    
    @FetchRequest(fetchRequest: TreeNode.getNodes()) var fetchedResults: FetchedResults<TreeNode>
    
    var body: some View {
        VStack {
            List {
                ForEach(fetchedResults, id: \.self) { node in
                    Text("\(node.name)")
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
        node.name = "\(fetchedResults.count + 1)"
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
