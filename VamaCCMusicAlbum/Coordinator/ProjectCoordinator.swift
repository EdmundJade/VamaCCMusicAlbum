//
//  MusicAlbumCoordinator.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 8/3/24.
//

import UIKit

protocol MusicAlbumCoordinator {
    var childCoordinators: [MusicAlbumCoordinator] { get set } //for future purposes
    var navigationController: UINavigationController { get set }

    func start()
}
