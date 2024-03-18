//
//  MainFlowCoordinator.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 8/3/24.
//

import UIKit

class MainFlowCoordinator: MusicAlbumCoordinator {
    var childCoordinators = [MusicAlbumCoordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let d = Dictionary<String, Any>.readFrom(String.FileConstants.route), let primary = d[String.KeyConstants.PrimaryController] as? String, let vc = MusicAlbumViewController.createWith(name: primary) {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
            //https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json
        }
    }
    
    
    func ownerList() {
//        let vc = OwnerListViewController()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
    }

}
