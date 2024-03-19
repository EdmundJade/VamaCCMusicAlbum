//
//  FeedInstance.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

class FeedInstance {
    let feeds: Results<Feed> = FeedRepository.shared.realm.objects(Feed.self)
    static let shared = FeedInstance()
    
    private var notificationToken:NotificationToken?
    
    private init() {
        notificationToken = feeds.observe { (changes) in
            switch changes {
            case .initial: break
                // Results are now populated and can be accessed without blocking the UI
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed.
                print("Deleted Feed indices: ", deletions)
                print("Inserted Feed indices: ", insertions)
                print("Modified Feed modifications: ", modifications)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
                    flowCoordinator.handleAlert(title: String.viewStrings.errorNotificationToken, message:error.localizedDescription)
                }
            }
        }
    }
    
    deinit {
        if let nt = notificationToken {
            nt.invalidate()
        }
    }
}
