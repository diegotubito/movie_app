//
//  CoreDataManager.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import Foundation
import CoreData

class CoreDataManager {
    private let viewContext: NSManagedObjectContext
    private let persistentContainer: NSPersistentContainer

    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error)")
            }
        }
        self.viewContext = persistentContainer.viewContext
    }
    
    func saveEntitiesInBackground<T: NSManagedObject, U>(
        models: [U],
        entityType: T.Type,
        configure: @escaping (U, T) -> Void,
        completion: @escaping () -> Void
    ) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        
        backgroundContext.perform {
            for model in models {
                let entity = T(context: backgroundContext)
                configure(model, entity)
            }
            
            do {
                try backgroundContext.save()
                print("\(T.self) entities saved to Core Data")
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Failed to save \(T.self) entities: \(error.localizedDescription)")
            }
        }
    }

    
    func fetchEntities<T: NSManagedObject>(ofType entityType: T.Type, completion: @escaping ([T]) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        do {
            let entities = try viewContext.fetch(fetchRequest)
            DispatchQueue.main.async {
                completion(entities)
            }
        } catch {
            print("Failed to fetch \(entityType): \(error.localizedDescription)")
            completion([])
        }
    }
    
    func deleteEntities<T: NSManagedObject>(ofType entityType: T.Type) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            print("All movies deleted successfully")
        } catch {
            print("Failed to delete all movies: \(error.localizedDescription)")
        }
    }
    
       func saveDataForEntity<T: NSManagedObject>(
           ofType entityType: T.Type,
           entityID: Int,
           dataFieldKeyPath: ReferenceWritableKeyPath<T, Data?>,
           data: Data,
           completion: @escaping () -> Void
       ) {
           let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
           fetchRequest.predicate = NSPredicate(format: "id == %d", entityID)
           
           do {
               let entities = try viewContext.fetch(fetchRequest)
               if let entity = entities.first {
                   entity[keyPath: dataFieldKeyPath] = data  // Set the data to the specified field
                   try viewContext.save()  // Save in the viewContext
               }
               DispatchQueue.main.async {
                   completion()
               }
           } catch {
               print("Failed to save data for \(entityType): \(error.localizedDescription)")
           }
       }
}
