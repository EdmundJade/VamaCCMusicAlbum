//
//  Top100ViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit
import Combine


class Top100ViewModel: MusicAlbumViewModel {
    var debouncer:SearchTextDebounce?
    var throttler:SearchTextThrottle?
    
    var rssFetcher = RSSFetcher()
    var albums:[MusicAlbum]?
    
    required init() {
        super.init()
        debouncer = SearchTextDebounce(searchCallback:searchForText)
        throttler = SearchTextThrottle(searchCallback:searchForText)
    }
    
    func searchForText(_ debouncedText:String) {
        print(debouncedText)
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

public final class SearchTextThrottle: ObservableObject {
    @Published var text: String = ""
    @Published var throttleText: String = ""
    private var bag = Set<AnyCancellable>()
    private var callback:(String) -> Void?

    public init(searchCallback: @escaping (String) -> Void?, dueTime: TimeInterval = 0.5) {
        callback = searchCallback
        $text
            .removeDuplicates()
            .throttle(for: .seconds(dueTime),
                      scheduler: DispatchQueue.main, latest: false)
            .sink(receiveValue: { [weak self] value in
                self?.throttleText = value
                self?.callback(value)
            })
            .store(in: &bag)
    }
}



public final class SearchTextDebounce: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var bag = Set<AnyCancellable>()
    private var callback:(String) -> Void?

    public init(searchCallback: @escaping (String) -> Void?, dueTime: TimeInterval = 0.5) {
        callback = searchCallback
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime),
                      scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
                self?.callback(value)
            })
            .store(in: &bag)
    }
}

