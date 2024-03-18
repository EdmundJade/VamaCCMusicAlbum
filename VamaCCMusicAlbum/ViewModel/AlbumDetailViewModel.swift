//
//  AlbumDetailViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class AlbumDetailViewModel: MusicAlbumViewModel {
    
    required init() {
        super.init()
    }
    
    func visitGenre(_ genre:[String:String]) {
        if let s = genre[String.KeyConstants.genreURL], let url = URL(string: s) {
            UIApplication.shared.open(url)
        }
    }
    
    func visitAlbum() {
        guard let p = params as? [String:Any], let s = p[String.KeyConstants.albumURL] as? String else {
            return
        }
        
        if let url = URL(string: s) {
            UIApplication.shared.open(url)
        }
    }
    
    func back() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.back()
        }
    }
    
}
