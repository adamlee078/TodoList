//
//  Recover.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/9.
//

import Foundation

func getTasksRecoverData() -> Array<Task> {
    var tasks = [Task]()
    if let data = UserDefaults.standard.value(forKey: "MyTask") as? Data {
        tasks = try! PropertyListDecoder().decode(Array<Task>.self, from: data)
    }
    
    return tasks
}

func setTasksRecoverData(_ tasks: Array<Task>) {
    for i in tasks {
        print("title=\(i.sTitle), deadline=\(i.deadline), impor=\(i.iImortance)")
    }
    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(tasks), forKey: "MyTask")
}
