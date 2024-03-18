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
    
    var allItems:[[String: Any]] = []
    
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
        
        cv.register(MusicAlbumTileCollectionViewCell.self, forCellWithReuseIdentifier: MusicAlbumTileCollectionViewCell.id)
        cv.register(MusicAlbumTileCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MusicAlbumTileCollectionHeaderView.id)
        
        return cv
    }()
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(collectionView)
        self.setUpConstraints()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
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
        guard let vm = self.viewModel as? Top100ViewModel else {
            return
        }
        
        vm.getData { (array,error) in
            if let a = array {
                self.allItems.append(contentsOf: a)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                //TODO: add error handling (Retry)
            }
        }
    }
}


extension Top100View: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = allItems[indexPath.item]
        guard let vm = viewModel as? Top100ViewModel else {
            return
        }
        
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
        return allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicAlbumTileCollectionViewCell.id, for: indexPath) as? MusicAlbumTileCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = allItems[indexPath.item]
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
