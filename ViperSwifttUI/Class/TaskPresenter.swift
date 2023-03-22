//
//  TaskPresenter.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import Foundation
import Combine
import SwiftUI

class TaskPresenter:ObservableObject {
    
    private let router = TaskRouter()
    
    private let interator:TaskInterator
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var taskViewModel = [TaskViewModel]()
    
    init(interator:TaskInterator) {
        
        self.interator = interator
        
        interator.$taskViewModel
            .assign(to: \.taskViewModel,on: self)
            .store(in: &cancellables)
    }
    
    func addTask() {
        interator.addTask()
    }
    
    func deleteTask(_ indeSet:IndexSet ) {
    
        interator.deleteTask(indeSet)
    }
    
    func detailsTaskView(_ task:TaskViewModel) -> some View {
        
        router.detailsView(task)
    }
    
    func showButtonItem()->some View {
     
        Button {
            self.addTask()
            
        } label: {
                Image(systemName: "plus")
        }
    }
}
