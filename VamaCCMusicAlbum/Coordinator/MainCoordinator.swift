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
    
    func handleAlert(title: String, message:String? = nil, yesAction:UIAlertAction? = nil, noAction:UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let y = yesAction {
            alertController.addAction(y)
        }
        
        if let n = noAction {
            alertController.addAction(n)
        }
        
        if alertController.actions.count == 0 {
            let okAction = UIAlertAction(title: String.viewStrings.ok, style: .cancel) { _ in
                // Handle No button tap
            }
            alertController.addAction(okAction)
        }
        
        if let currentController = navigationController.topViewController {
            currentController.present(alertController, animated: true, completion: nil)
        }
    }
}
