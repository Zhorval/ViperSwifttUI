//
//  CoreDataStack.swift
//  ViperSwifttUI
//
//  Created by Pablo  on 22/3/23.
//

import Foundation
import Combine
import CoreData



protocol ProtocolDataProvider {
    var taskPublisher:Published<[Task]>.Publisher { get }
    func addTask(uuid:UUID,body:String,title:String)
    func deleteTask(_ task:Task)
    func deleteAll()
}

class CoreDataStack {
    
    private var managerObjectContext:NSManagedObjectContext

    private var cancellabeles = Set<AnyCancellable>()

    @Published var task = [Task]()
    
    init(context:NSManagedObjectContext) {
        
        self.managerObjectContext = context
        
        self.task = allTask()
    }
    
    private func allTask() -> [Task] {
        
        do {
            
            let fetch:NSFetchRequest<Task> = Task.fetchRequest()
            
            return try self.managerObjectContext.fetch(fetch)
            
        } catch let error as NSError{
            print("\(error) \(error.userInfo)")
            return []
        }
    }
    
    private func saveTask() {
        
        do {
        
            try self.managerObjectContext.save()
            
        } catch let error as NSError {
            debugPrint("\(error) - \(error.userInfo)")
        }
        publish()
    }
    
    private func removeAllTask() {
        
        for x in allTask() {
            managerObjectContext.delete(x)
        }
        
        saveTask()
    }
    
    private func publish() {
        task = allTask()
    }
}


extension CoreDataStack:ProtocolDataProvider {
    
    var taskPublisher: Published<[Task]>.Publisher {
        $task
    }
    
    func addTask(uuid:UUID,body: String, title: String) {
        
        let task = Task(context: managerObjectContext)
        
        task.body = body
        
        task.id = uuid
        
        task.timestamp = .now
        
        task.title = title
        
        saveTask()
    }
    
    func deleteTask(_ task: Task) {
        
        managerObjectContext.delete(task)
        
        saveTask()
    }
    
    func deleteAll() {
    
        removeAllTask()
    }
}

