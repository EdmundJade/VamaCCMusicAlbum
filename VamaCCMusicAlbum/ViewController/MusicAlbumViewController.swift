//
//  MusicAlbumViewController.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class MusicAlbumViewController:UIViewController {
    weak var coordinator: MainFlowCoordinator?
    var params: Any? {
        didSet {
            if let vm = self.viewModel {
                vm.params = params
            }
        }
    }
    var viewModel: MusicAlbumViewModel?
    var naturalView: MusicAlbumView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.viewModel = MusicAlbumViewModel.createWith(vcName: String(describing: type(of: self)))
        
        self.naturalView = MusicAlbumView.createWith(vcName: String(describing: type(of: self)))
        
        guard let nv = self.naturalView else {
            return
        }
        
        if let vm = self.viewModel {
            if let p = params {
                vm.params = p
            }
            nv.bindViewModel(vm)
        }
        self.view.addSubview(nv)
        self.setUpConstraints()
        
    }
    
    func setUpConstraints() {
        guard let nv = self.naturalView else {
            return
        }
        
        let naturalViewConstraints = [
            nv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            nv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            nv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            nv.topAnchor.constraint(equalTo: self.view.topAnchor)
        ]
        NSLayoutConstraint.activate(naturalViewConstraints)
    }
}
