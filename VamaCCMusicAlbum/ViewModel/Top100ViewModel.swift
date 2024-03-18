//
//  Top100ViewModel.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation


class Top100ViewModel: MusicAlbumViewModel {
    var rssFetcher = RSSFetcher()
    
    required init() {
        super.init()
//        self.rssFetcher.fetchData { (dict,error) in
//            print("abcd")
//        }
    }
    
    func getData(completion: @escaping ([[String:Any]]?, Error?) -> Void) {
        self.rssFetcher.fetchData { (array,error) in
            completion(array,error)
        }
    }

//    func hasRating() -> Bool {
//        guard let rating = rating, rating.intValue > 1 else { return false }
//        return true
//    }

    //Derieved fields
//    internal var priceString: NSAttributedString? {
//        guard let price = price else { return nil }
//        
//        var color = UIColor.black
//        if !isInStock {
//            color = UIColor.laz_color(withHex: "#666666")
//        }
//        
//        let attributes: [NSAttributedString.Key: Any]
//        attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.la_font(withSize: RM.shared.height(16), weight: .bold)]
//        return NSAttributedString(string: "\(price) ", attributes: attributes)
//    }
//
//    internal var strikeOutPriceString: NSAttributedString? {
//        guard let originalPrice = originalPrice else { return nil }
//
//        let strikeOutTextAttributes = [NSAttributedString.Key.strikethroughStyle: 1,
//                                       NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.la_font(withSize: RM.shared.height(12), weight: .regular)] as [NSAttributedString.Key : Any]
//        return NSAttributedString(string: originalPrice, attributes: strikeOutTextAttributes)
//    }
//
//    internal var placeholderImageName: String {
//        return LAAdapter.isShopMMTarget() ? "VX-Shop-Product-Placeholder" : "VX-dMart-Product-Placeholder"
//    }
}
