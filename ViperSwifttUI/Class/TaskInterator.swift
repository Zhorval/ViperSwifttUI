//
//  TaskInterator.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import Foundation
import Combine


class TaskInterator {
    
    private let model:DataLayer
    private var cancellable = Set<AnyCancellable>()
    @Published var taskViewModel = [TaskViewModel]()
    
    init(model:DataLayer) {
        
        self.model = model
        setup()
    }
    
    private func setup(){
        
        self.model.$tasks
            .map({ tasks -> [TaskViewModel] in
                return tasks.map{ TaskViewModel(id: $0.id, body: $0.body, title: $0.title, timestamp: Date.now) }
            })
            .replaceError(with: [])
            .assign(to: \.taskViewModel,on: self)
            .store(in: &cancellable)
        
    }
    
    func addTask() {
        model.addTask(uuid: UUID(), body: "Reunion de equipo", title: "Reunion dia 12")
    }
    
    
    func deleteTask(_ index:IndexSet) {
        
        var copy = taskViewModel
        
        copy.move(fromOffsets: index, toOffset: 0)
        
        if let taskToDelete = model.tasks.filter({ copy.first!.id == $0.id}).first {
            model.removeTask(taskToDelete)
        } else {
            
            copy.map { debugPrint($0.id)}
            debugPrint("-----")
            model.tasks.map { debugPrint($0.id)}
            
            
            
            model.removeAll()
        }
    }
}
