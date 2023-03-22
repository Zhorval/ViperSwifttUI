//
//  TaskListView.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var task:TaskPresenter
    
    var body: some View {
        NavigationView {
            
            List{
                ForEach(task.taskViewModel,id: \.id) { task in
                    NavigationLink(destination: TaskDetailsView(task: task)) {
                        HStack{
                            VStack(alignment:.trailing) {
                                Text(task.title).font(.title)
                                Text(task.body).font(.title3)
                                Text(task.timestamp,style: .date)
                            }
                            HStack {
                                Image(systemName: "clock")
                                Text(task.timestamp,style: .time).font(.title)
                            }
                        }
                    }
                }.onDelete { indexSet in
                    task.deleteTask(indexSet)
                }
            }
            .navigationTitle("Task daily")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems( trailing: task.showButtonItem())
        }
    }
}




struct TaskListView_Previews: PreviewProvider {
    
    static let route = TaskRouter()
    
    static var previews: some View {
        route.listView(context: PersistenceController.shared.container.viewContext)
    }
}

