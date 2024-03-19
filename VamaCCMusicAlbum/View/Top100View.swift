//
//  Top100View.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

let collectionPadding = 15.0
let normalReferenceSize = 65.0
let mosiacReferenceSize = 46.0

class Top100View: MusicAlbumView {
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSizeMake(UIScreen.main.bounds.width, normalReferenceSize)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: String.viewStrings.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        cv.refreshControl = refreshControl
        cv.register(MusicAlbumTileCollectionViewCell.self, forCellWithReuseIdentifier: MusicAlbumTileCollectionViewCell.id)
        cv.register(MusicAlbumTileCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MusicAlbumTileCollectionHeaderView.id)
        
        return cv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var center = CGPoint.zero
        if let delegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = delegate.flowCoordinator, let top = flowCoordinator.navigationController.topViewController{
            center = top.view.center
        }
        
        if #available(iOS 13.0, *) {
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.center = center
            activityView.hidesWhenStopped = true
            return activityView
        } else {
            let activityView = UIActivityIndicatorView(style: .whiteLarge)
            activityView.center = center
            activityView.hidesWhenStopped = true
            return activityView
        }
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(collectionView)
        self.addSubview(activityIndicator)
        self.setUpConstraints()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.handleAlert(title: String.viewStrings.errorCoding)
        }
        fatalError(String.viewStrings.errorCoding)
    }
    
    func setUpConstraints() {
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    override func bindViewModel(_ viewModel:MusicAlbumViewModel) {
        super.bindViewModel(viewModel)
        self.getData()
    }
    
    func getData() {
        guard let vm = self.viewModel as? Top100ViewModel else {
            return
        }
        
        if vm.albums == nil {
            activityIndicator.startAnimating()
        } else if let albums = vm.albums, albums.isEmpty {
            activityIndicator.startAnimating()
        }
        
        vm.getData { () in
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            self.collectionView.reloadData()
            if let rc = self.collectionView.refreshControl {
                rc.endRefreshing()
            }
        }
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
       // Code to refresh table view
        self.getData()
    }
}


extension Top100View: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vm = viewModel as? Top100ViewModel, let items = vm.albums else {
            return
        }
        let item = items[indexPath.item]
        
        vm.selectItem(item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = self.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? MusicAlbumTileCollectionHeaderView {
            
            switch header.switchModeOnOffSet(scrollView.contentOffset.y+scrollView.adjustedContentInset.top) {
            case .others, .normal:
                if let b = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    b.headerReferenceSize = CGSizeMake(UIScreen.main.bounds.width, normalReferenceSize)
                }
                
                break
            case .mosiac:
                if let b = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    b.headerReferenceSize = CGSizeMake(UIScreen.main.bounds.width, mosiacReferenceSize)
                }
                break
            }
        }
    }
}

extension Top100View: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let vm = viewModel as? Top100ViewModel, let items = vm.albums else {
            return 0
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicAlbumTileCollectionViewCell.id, for: indexPath) as? MusicAlbumTileCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let vm = viewModel as? Top100ViewModel, let items = vm.albums else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.bindData(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicAlbumTileCollectionHeaderView.id, for: indexPath) as? MusicAlbumTileCollectionHeaderView else {
            return UICollectionReusableView()
        }
        view.bindCollection(collectionView)
        return view
    }
    
}

extension Top100View: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = UIScreen.main.bounds.width
        
        let sizeWidth = (totalWidth-collectionPadding*3.0) / 2.0
        return CGSize(width: sizeWidth, height: sizeWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionPadding, bottom: 0, right: collectionPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionPadding
    }
    
}
