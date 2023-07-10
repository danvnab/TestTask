//
//  RealmManager.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    private init() {}
    static let shared = RealmManager()
    
    var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Unable to create Realm instance \(error)")
        }
    }

    func save<T: Object>(_ object: T) throws {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            throw error
        }
    }
    
    func update<T: Object>(_ object: T) throws {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw error
        }
    }

    func delete<T: Object>(_ object: T) throws {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw error
        }
    }
    
    func deleteAllObjects<T: Object>(ofType type: T.Type) {
        do {
            try realm.write {
                let allObjects = realm.objects(type)
                realm.delete(allObjects)
            }
        } catch {
            print("Failed to delete objects in Realm: \(error.localizedDescription)")
        }
    }

    func getObject<T: Object>(ofType type: T.Type, filter: String) -> Results<T>? {
        let results: Results<T> = realm.objects(type).filter(filter)
        return results
    }
    
    func getAllObjects<T: Object>(ofType type: T.Type) -> Results<T>? {
        let results: Results<T> = realm.objects(type)
        return results
    }
}
