//
//  TreeNodeWrapperView.swift
//  DynamicFetchRequest
//
//  Created by SchwiftyUI on 9/11/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct TreeNodeWrapperView: View {
    var root: TreeNode?
    
    init(root: TreeNode? = nil) {
        self.root = root
        print("Init called for TreeNodeWrapperView(\(root?.name ?? "root"))")
    }
    
    var body: some View {
        TreeNodeView(root: root)
    }
}

struct TreeNodeWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        TreeNodeWrapperView()
    }
}
