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
    
    required init() {
        super.init()
    }
    
    func getData(completion: @escaping ([[String:Any]]?, Error?) -> Void) {
        self.rssFetcher.fetchData { (array,error) in
            completion(array,error)
        }
    }
    
    func selectItem(_ item: [String:Any]) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.goToNext(item)
        }
    }
}
