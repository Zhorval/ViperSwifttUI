//
//  TaskDetailsView.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import SwiftUI

struct TaskDetailsView: View {
    
    let task:TaskViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .center,spacing: 50){
                GroupBox {
                    Text(task.title).font(.title)
                    Text(task.body).font(.title3)
                    Text(task.timestamp, style: .date).font(.subheadline)
                }
            }.navigationTitle(Text(task.timestamp, style: .date))
        }
    }
}

#if DEBUG
struct TaskDetailsView_Previews: PreviewProvider {
    
     static let task:TaskViewModel =
        TaskViewModel(id: UUID(), body: "Reunion dia 1", title: "Reunion equipo", timestamp: Date.now)
    
    static let route = TaskRouter()
    
    static var previews: some View {
        route.detailsView(task)
    }
}
#endif
