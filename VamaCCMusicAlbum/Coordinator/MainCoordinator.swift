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
        }
    }
    
    func goToNext() {
        goToNext(nil)
    }
    
    func goToNext(_ params:Any?) {
        if let currentController = navigationController.topViewController, let d = Dictionary<String, Any>.readFrom(String.FileConstants.route), let flowBase = d[String.KeyConstants.flowBase] as? [String:String], let next = flowBase[String(describing: type(of: currentController))], let vc = MusicAlbumViewController.createWith(name: next) {
            vc.coordinator = self
            vc.params = params
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
