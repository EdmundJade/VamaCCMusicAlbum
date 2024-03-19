//
//  Top100ViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit


class Top100ViewModel: MusicAlbumViewModel {
    var rssFetcher = RSSFetcher()
    var albums:[MusicAlbum]?
    
    required init() {
        super.init()
    }
    
    func getData(completion: @escaping () -> Void) {
        if let feed = FeedInstance.shared.feeds.first {
            //return first before updating
            self.albums = feed.results.toArray()
            completion()
        }
        
        self.rssFetcher.fetchData { (feeds,error) in
            DispatchQueue.main.async {
                if let f = feeds, let feed = f.first {
                    //return first before updating
                    self.albums = feed.results.toArray()
                    completion()
                } else {
                    //error flow
                    self.startAlert(error: error ?? NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedAbsence, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedInstanceRetrievalFailed]) as Error, completion: completion)
                }
                
            }
        }
    }
    
    func startAlert(error:Error, completion: @escaping () -> Void) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            
            let yesAction = UIAlertAction(title: String.viewStrings.yes, style: .default) { _ in
                // Handle Yes button tap
                self.getData(completion: completion)
            }

            let noAction = UIAlertAction(title: String.viewStrings.no, style: .cancel) { _ in
                // Handle No button tap
                completion()
            }
            
            flowCoordinator.handleAlert(title: String.viewStrings.errorTitle, message: "Error Message: \(error.localizedDescription) \n\(String.viewStrings.errorMessage)", yesAction: yesAction, noAction: noAction)
        }
    }
    
    func selectItem(_ item: MusicAlbum) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.goToNext(item)
        }
    }
}
