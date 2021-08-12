//
//  Task.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/6.
//

import Foundation

struct Task: Codable {
    var sTitle: String
    var deadline: String
    var iImortance: Int
    
    init(title: String, deadline: String, importance: Int) {
        self.sTitle = title
        self.deadline = deadline
        self.iImortance = importance
    }
    
    mutating func setTaskData(title: String, deadline: String, importance: Int) {
        self.sTitle = title
        self.deadline = deadline
        self.iImortance = importance
    }
}
