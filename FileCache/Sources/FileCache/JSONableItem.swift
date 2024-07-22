//
//  File.swift
//  
//
//  Created by Александр  Сухинин on 11.07.2024.
//

import Foundation

public protocol JSONableItem{
    static func parse(json: Any) -> Self?
    var json: Any { get}
    var id: String { get }
}
