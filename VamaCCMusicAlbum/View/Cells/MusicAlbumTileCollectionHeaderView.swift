//
//  MusicAlbumTileCollectionHeaderViewCell.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import UIKit

class MusicAlbumTileCollectionHeaderView: UICollectionReusableView {
    
    static var id: String {
        return "MusicAlbumTileCollectionHeaderView"
    }
    
    enum headerMode:Int {
        case normal = 0
        case mosiac = 1
        case others = 2
    }
    
    private var currentMode:headerMode = headerMode.others
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 34, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor(rgb: 0x111226)
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    private lazy var mosiacBlurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var blurConstraints:[NSLayoutConstraint]?
    
    //首先创建一个模糊效果
            
            //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.title.text = String.collectionHeaders.top100
        setupViews()
        setupConstraints()
        _ = toggleNormal()
    }
    
    required init?(coder: NSCoder) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let flowCoordinator = appDelegate.flowCoordinator {
            flowCoordinator.handleAlert(title: String.viewStrings.errorInitializationForObjects)
        }
        fatalError(String.viewStrings.errorInitializationForObjects)
    }
    
    private func setupConstraints() {
        let constraints = [
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func bindCollection(_ collectionView: UICollectionView) {
        setupBlurConstraints(collectionView)
    }
    
    private func setupBlurConstraints(_ collectionView: UICollectionView) {
        if blurConstraints != nil {
            return
        }
            
        blurConstraints = [
            mosiacBlurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mosiacBlurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mosiacBlurView.topAnchor.constraint(equalTo: self.topAnchor, constant: -collectionView.adjustedContentInset.top),
            mosiacBlurView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        if let b = blurConstraints {
            NSLayoutConstraint.activate(b)
        }
    }
    
    private func setupViews() {
        self.addSubview(self.mosiacBlurView)
        self.addSubview(self.title)
    }
    
    func switchModeOnOffSet(_ offset:CGFloat) -> headerMode {
        return offset > 0 ? self.toggleMosiac() : self.toggleNormal()
    }
    
    private func toggleMosiac() -> headerMode {
        if (self.currentMode == headerMode.mosiac) {
            return self.currentMode
        }
            
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.textAlignment = .center
        self.currentMode = headerMode.mosiac
        self.backgroundColor = nil
        self.mosiacBlurView.alpha = 1.0
        return self.currentMode
    }
    
    private func toggleNormal() -> headerMode {
        if (self.currentMode == headerMode.normal) {
            return self.currentMode
        }
        
        title.font = .systemFont(ofSize: 34, weight: .bold)
        title.textAlignment = .left
        
//        self.backgroundColor = .white
        self.currentMode = headerMode.normal
        self.mosiacBlurView.alpha = 0.0
        return self.currentMode
    }
}

