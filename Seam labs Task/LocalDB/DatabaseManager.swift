//
//  DatabaseManager.swift
//  MindValleyTask
//
//  Created by Amr on 05/02/2023.
//

protocol DataBaseManager: AnyObject {

    func insert<Input>(data: Input,
                       entity: String,
                       completion: ((Result<Void, Error>) -> Void)?)
    func fetch<Query, Output>(query: Query,
                              output: Output.Type) throws -> [Output]
    func getRecordsCount<Query>(for query: Query) throws -> Int
    func delete(object: AnyObject,
                completion: ((Result<Void, Error>) -> Void)?)
    func deleteAll(entityName: String,
                   completion: ((Result<Void, Error>) -> Void)?)
    func save() throws
}

extension DataBaseManager {

    func insert<Input>(data: Input,
                       entity: String) {
        self.insert(data: data,
                    entity: entity,
                    completion: nil)
    }

    func delete(object: AnyObject) {
        self.delete(object: object,
                    completion: nil)
    }

    func deleteAll(entityName: String) {
        self.deleteAll(entityName: entityName,
                       completion: nil)
    }
}
