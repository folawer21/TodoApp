//
//  BaseURL.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 18.07.2024.
//

import Foundation

struct NetworkDefault {
    static let token = "Elu"
    static let deviceId = 1110101
    static let baseURL = "https://hive.mrdekk.ru/todo"
    static let todoListRequestURLString = baseURL + "/list"
    static let getItemByIdRequestURLString = baseURL + "/list/"
    static let changeItemByIdRequestURLString = baseURL + "/list/"
    static let deleteItemByIdRequestURLString = baseURL + "/list/"
}
