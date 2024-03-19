//
//  MusicAlbumObserver.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 19/3/24.
//

import Foundation
import RealmSwift

class MusicAlbumsInstance {
    let albums: Results<MusicAlbum> = FeedRepository.shared.realm.objects(MusicAlbum.self)
    static let shared = MusicAlbumsInstance()
    
    private var notificationToken:NotificationToken?
    
    private init() {
        notificationToken = albums.observe { (changes) in
            switch changes {
            case .initial: break
                // Results are now populated and can be accessed without blocking the UI
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed.
                print("Deleted Music Album indices: ", deletions)
                print("Inserted Music Album indices: ", insertions)
                print("Modified Music Album modifications: ", modifications)
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
