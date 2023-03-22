//
//  DataLayer.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import Foundation
import Combine

class DataLayer {
    
    private let dataProvider:ProtocolDataProvider
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var tasks = [Task]()
    
    init(dataProvider: ProtocolDataProvider)
    {
        self.dataProvider = dataProvider
        setup()
    }
    
    private func setup() {
        
        self.dataProvider.taskPublisher
            .assign(to: \.tasks,on: self)
            .store(in: &cancellables)
    }
    
    func addTask(uuid:UUID,body:String,title:String) {
        
        dataProvider.addTask(uuid:uuid,body: body, title: title)
    }
    
    func removeTask(_ task:Task) {
        dataProvider.deleteTask(task)
    }
    
    func removeAll() {
        dataProvider.deleteAll()
    }
}
