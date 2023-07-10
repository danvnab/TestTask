//
//  RealmManager.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import Realm
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
                realm.delete(object, cascading: true)
            }
        } catch {
            throw error
        }
    }
    
    func deleteAllObjects<T: Object>(ofType type: T.Type) {
        do {
            try realm.write {
                let allObjects = realm.objects(type)
                realm.delete(allObjects, cascading: true)
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

protocol CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }
    
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}

private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }
    
    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase {
                toBeDeleted.insert(entity)
            } else if let list = value as? RLMSwiftCollectionBase {
                for index in 0..<list._rlmCollection.count {
                    if let entity = list._rlmCollection.object(at: index) as? RLMObjectBase {
                        toBeDeleted.insert(entity)
                    }
                }
            }
        }
        delete(element)
    }
}
