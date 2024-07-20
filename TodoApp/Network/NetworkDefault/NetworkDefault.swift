//
//  BaseURL.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 18.07.2024.
//

import Foundation

struct NetworkDefault {
    static let token = "Elu"
    static let deviceId = "cac9c338-241e-4d1b-9fcd-4c09a9d662a0"
    static let baseURL = "https://hive.mrdekk.ru/todo"
    static let todoListRequestURLString = baseURL + "/list"
    static let getItemByIdRequestURLString = baseURL + "/list/"
    static let changeItemByIdRequestURLString = baseURL + "/list/"
    static let deleteItemByIdRequestURLString = baseURL + "/list/"
    static let addItemRequestURLString = baseURL + "/list"
}
