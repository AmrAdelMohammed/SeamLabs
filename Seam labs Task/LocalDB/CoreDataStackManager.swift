//
//  CoreDataStackManager.swift
//  Seam labs Task
//
//  Created by Amr Adel on 05/09/2023.
//

import CoreData

enum CoreDataContainer: String {
    case news = "NewsEntites"
}

class CoreDataStackManager: DataBaseManager {

    private let persistentContainer: NSPersistentContainer
    private(set) var viewContext: NSManagedObjectContext!
    private(set) var backgroundContext: NSManagedObjectContext!

    init(containerName: CoreDataContainer = .news,
         saveToDisk: Bool = true) {
        let bundle = Bundle(for: Self.self)
        let modelURL = bundle.url(forResource: containerName.rawValue,
                                  withExtension: "momd")!
        self.persistentContainer = NSPersistentContainer(name: containerName.rawValue,
                                                         managedObjectModel: NSManagedObjectModel(contentsOf: modelURL)!)
        if !saveToDisk {
            let persistentStoreDescription = NSPersistentStoreDescription()
            persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        }
        self.start()
    }

    private func start() {
        self.persistentContainer.loadPersistentStores { ( _, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            self.viewContext = self.persistentContainer.viewContext
            self.backgroundContext = self.persistentContainer.newBackgroundContext()
        }
    }

    func insert<Input>(data: Input,
                       entity: String,
                       completion: ((Result<Void, Error>) -> Void)?) {
        var inputs = [NSManagedObject]()
        if let data = data as? [NSManagedObject] {
            inputs = data
        } else if let data = data as? NSManagedObject {
            inputs.append(data)
        } else {
            fatalError("data must be NSManagedObject child")
        }
        //
        self.backgroundContext.perform {
            inputs.forEach { (data) in
                self.backgroundContext.insert(data)
            }
            do {
                try self.save()
                completion?(.success(()))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func fetch<Query, Output>(query: Query,
                              output: Output.Type) throws -> [Output] {
        guard let query = query as? NSFetchRequest<NSFetchRequestResult> else {
            fatalError("query must be of type NSFetchRequest<NSFetchRequestResult>")
        }
        var result: Result<[Output], Error>!
        self.backgroundContext.performAndWait {
            result = self.performFetch(query: query,
                                       output: output)
        }
        return try result.get()
    }

    private func performFetch<Output>(query: NSFetchRequest<NSFetchRequestResult>,
                                      output: Output.Type) -> Result<[Output], Error> {
        return tryCatch {
            let data = try self.backgroundContext.fetch(query)
            guard let data = data as? [Output] else {
                fatalError("\(Output.self) is invalid output type for \(query)")
            }
            return data
        }
    }

    func getRecordsCount<Query>(for query: Query) throws -> Int {
        guard let query = query as? NSFetchRequest<NSFetchRequestResult> else {
            fatalError("query must be of type NSFetchRequest<NSFetchRequestResult>")
        }
        var result: Result<Int, Error>!
        self.backgroundContext.performAndWait {
            result = tryCatch {
                try self.backgroundContext.count(for: query)
            }
        }
        return try result.get()
    }

    func delete(object: AnyObject,
                completion: ((Result<Void, Error>) -> Void)?) {
        guard let object = object as? NSManagedObject else {
            fatalError("object must be an NSManagedObject")
        }
        self.backgroundContext.perform {
            self.backgroundContext.delete(object)
            do {
                try self.save()
                completion?(.success(()))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func deleteAll(entityName: String,
                   completion: ((Result<Void, Error>) -> Void)?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        self.backgroundContext.perform {
            do {
                try self.backgroundContext.execute(deleteRequest)
                completion?(.success(()))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    /// Saves changes in background context if any
    func save() throws {
        guard self.backgroundContext.hasChanges else { return }
        try self.backgroundContext.save()
    }

    /// try catch blocks wrapper to provide a Result type instead
    private func tryCatch<Output>(_ block: () throws -> Output) -> Result<Output, Error> {
        do {
            let output = try block()
            return .success(output)
        } catch {
            return .failure(error)
        }
    }
}


