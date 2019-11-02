//
//  EditNode.swift
//  DynamicFetchRequest
//
//  Created by John Masterson on 11/2/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI
import CoreData

struct EditNode: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var nodeName: String = ""
    
    @ObservedObject var node: TreeNode
    
    var body: some View {
        VStack {
            Button(action: {
                self.node.name = self.nodeName
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
                
                self.node.objectWillChange.send()
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
            TextField("Node Name", text: $nodeName)
        }
        .onAppear(perform: {
            self.nodeName = self.node.name
        })
    }
}

struct EditNode_Previews: PreviewProvider {
    static var previews: some View {
        EditNode(node: TreeNode())
    }
}
