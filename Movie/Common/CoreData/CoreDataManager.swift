//
//  CoreDataManager.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//
import Foundation
import CoreData

class CoreDataManager {
    let viewContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer

    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error)")
            }
        }
        self.viewContext = persistentContainer.viewContext
    }
    
    func saveEntities<T: NSManagedObject, U>(
        models: [U],
        entityType: T.Type,
        configure: @escaping (U, T) -> Void,
        completion: @escaping () -> Void
    ) {
        
        for model in models {
            let entity = T(context: viewContext)
            configure(model, entity)
        }
        
        do {
            try viewContext.save()
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print("Failed to save \(T.self) entities: \(error.localizedDescription)")
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
                   entity[keyPath: dataFieldKeyPath] = data 
                   try viewContext.save()
               }
               DispatchQueue.main.async {
                   completion()
               }
           } catch {
               print("Failed to save data for \(entityType): \(error.localizedDescription)")
           }
       }
}

extension CoreDataManager {
    func toggleBookmark(detailMovie: DetailModel, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<WatchList> = WatchList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", detailMovie._id)
        
        do {
            let bookmarks = try viewContext.fetch(fetchRequest)
            
            if let existingBookmark = bookmarks.first {
                viewContext.delete(existingBookmark)
            } else {
                let newBookmark = WatchList(context: viewContext)
                newBookmark.id = Int32(detailMovie._id)
                newBookmark.originalTitle = detailMovie.originalTitle
                newBookmark.posterImageData = detailMovie.posterImageData
                newBookmark.voteAverage = detailMovie.voteAverage
                newBookmark.releaseDate = detailMovie.releaseDate
                newBookmark.runtime = Int32(detailMovie.runtime)
            }
            
            try viewContext.save()
            
            DispatchQueue.main.async {
                completion(bookmarks.first == nil)
            }
        } catch {
            print("Error toggling bookmark for movieId \(detailMovie._id): \(error.localizedDescription)")
            completion(false)
        }
    }
}
