//
//  RSSFetcher.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation
import RealmSwift

public class RSSFetcher {
    func fetchData(completion: @escaping (Results<Feed>?, Error?) -> Void) {
        guard let url = URL(string: String.URLConstants.rssFeed) else {
            completion(FeedInstance.shared.feeds, NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedAbsence, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedAbsence]) as Error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(FeedInstance.shared.feeds, NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedNoResults, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedNoResults]) as Error)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                    guard let jsonFeedObject = json[String.KeyConstants.rssFeed] as? [String:Any] else {
                        completion(FeedInstance.shared.feeds, NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedNoResults, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedNoResults]) as Error)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        FeedRepository.shared.parseJson(json: jsonFeedObject) { error in
                            let feeds = FeedInstance.shared.feeds
                            completion(feeds,error)
                        }
                    }
                    
                }
            } catch {
                completion(FeedInstance.shared.feeds, error)
            }
        }
        task.resume()
    }
    
}


