//
//  TodoDataSource.swift
//  HomeWorkToDo
//
//  Created by aluno on 11/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import Foundation
final class TodoDataSource {
    
    static let shared = TodoDataSource()
    private init(){}
    
    var priorityArray: [String] = []
    var homeArray: [String] = []
    var dailyArray: [String] = []
    var typeTodoArray: [String] = []
    
    var todosCollection = CollectionModel()
    var todos: [TodoModel] = [
//        TodoModel(type: .onPriority, todoDescription: "Today We Rock", date: Date()),
//        TodoModel(type: .daily, todoDescription: "We Daily Rock", date: Date()),
//        TodoModel(type: .home, todoDescription: "We rock at home ", date: Date()),
//        TodoModel(type: .daily, todoDescription: "we daily rock 2", date: Date()),
    ]
    
}
