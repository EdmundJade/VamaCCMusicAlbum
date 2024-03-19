//
//  FeedRepository.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

typealias ExecutionHandler = ()  -> Void

protocol repository {
  func deleteAll()
  func delete(_ item: ObjectBase)
  func insertOrUpdate(_ item: Object)
  func delete<S: Sequence>(_ items: S) where S.Iterator.Element: ObjectBase
  func insertOrUpdate<S: Sequence>(_ items: S) where S.Iterator.Element: Object
  func update(_ handler:ExecutionHandler)
}

class FeedRepository:repository {
    static let shared = FeedRepository()
    internal var realm:Realm {
        get {
            do {
                let r = try Realm()
                return r
            } catch {
                // Error Handling
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                    flowCoordinator.handleAlert(title: String.viewStrings.errorDeletion, message:error.localizedDescription)
                }
                fatalError(String.viewStrings.errorInitialization)
            }
        }
    }
    
    private init() {
    }
    
    deinit {
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorDeletionAll, message:error.localizedDescription)
            }
        }
    }
    
    func delete(_ item: ObjectBase) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorDeletion, message:error.localizedDescription)
            }
        }
    }
    
    func insertOrUpdate(_ item: Object) {
        do {
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorInsertion, message:error.localizedDescription)
            }
        }
    }
    
    func delete<S: Sequence>(_ items: S) where S.Iterator.Element: ObjectBase {
        do {
            try realm.write {
                realm.delete(items)
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorDeletionForArray, message:error.localizedDescription)
            }
        }
    }
    
    func insertOrUpdate<S: Sequence>(_ items: S) where S.Iterator.Element: Object {
        do {
            try realm.write {
                realm.add(items, update: .all)
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorInsertionForArray, message:error.localizedDescription)
            }
        }
    }
    
    func update(_ handler:ExecutionHandler) {
        do {
            try realm.write {
                handler()
            }
        } catch {
            // Error Handling
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                flowCoordinator.handleAlert(title: String.viewStrings.errorUpdate, message:error.localizedDescription)
            }
        }
    }
    
    
    func parseJson(json: [String:Any], completion: @escaping (Error?) -> Void) {
        var e:Error?
        do {
            try realm.write {
                self.realm.create(Feed.self, value: json, update: .all)
                completion(e)
            }
        } catch {
            e = error
            completion(e)
        }
    }
    
    
}
