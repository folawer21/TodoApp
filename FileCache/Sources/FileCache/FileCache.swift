// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class FileCache<T: JSONableItem> {
    enum FileCacheErrors: Error {
        case fileDoesntExist
        case fileNotFound
        case jsonError
    }
    
    public init() {
    }
    private(set) var todoitems: [T] = []
    public func checkIfAlreadyHere(id: String) -> Int? {
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        return index
    }
    public func addNewItem(item: T) {
        if let index = checkIfAlreadyHere(id: item.id) {
            todoitems[index] = item
        } else {
            todoitems.append(item)
        }
    }
    public func removeItem(item: T) {
        todoitems.removeAll(where: {$0.id == item.id})
    }
    public func loadItemsFromFile(filename: String ) throws -> [T] {
        do {
            if !checkFileExisting(filename: filename) {
                throw FileCacheErrors.fileDoesntExist
            }
            guard let fileName = getFile(name: filename) else {
                throw FileCacheErrors.fileNotFound
            }
            let data = try Data(contentsOf: fileName)
            guard let itemsJson = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                throw FileCacheErrors.jsonError
            }
            let todoitems = itemsJson.compactMap {
                T.parse(json: $0)
            }
            return todoitems
        } catch {
            throw FileCacheErrors.jsonError
        }
    }
    public func saveItemsToFile(file: String ) throws {
        do {
        if !checkFileExisting(filename: file) {
            throw FileCacheErrors.fileDoesntExist
        }
        guard let fileName = getFile(name: file) else {
            throw FileCacheErrors.fileNotFound
        }
        let itemsJson = todoitems.map {$0.json}
        let data = try JSONSerialization.data(withJSONObject: itemsJson)
        try data.write(to: fileName)
        } catch {
            print(error)
        }
    }
    func checkFileExisting(filename: String) -> Bool {
        guard let fileURL = getFile(name: filename) else {return false }
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    func getFile(name: String) -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let url = directory.appendingPathComponent(name)
        return url
    }
}

