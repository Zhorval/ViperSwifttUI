//
//  TaskRouter.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import Foundation
import CoreData
import SwiftUI

class TaskRouter {
    
    func listView(context:NSManagedObjectContext) -> some View {
        
        let persistence = CoreDataStack(context: context)
        
        let dataLayer = DataLayer(dataProvider: persistence)
        
        let contentView = TaskListView(task: TaskPresenter(interator: TaskInterator(model: dataLayer)))
        
        return contentView
    }
    
    func detailsView(_ task:TaskViewModel) -> some View {
        
        return TaskDetailsView(task: task)
    }
}
