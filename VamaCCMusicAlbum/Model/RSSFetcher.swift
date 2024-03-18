//
//  RSSFetcher.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import Foundation

public class RSSFetcher {
    func fetchData(completion: @escaping ([[String:Any]]?, Error?) -> Void) {
        guard let url = URL(string: String.URLConstants.rssFeed) else {
            completion(nil, NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedAbsence, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedAbsence]) as Error)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                    guard let arr = array[String.KeyConstants.rssFeed] as? [String:Any], let allResultsArray = arr[String.KeyConstants.rssResults] as? [[String:Any]] else {
                        completion(nil, NSError(domain: String.errorDomainConstants.rssFeed, code: Int.errorCodeConstants.rssFeedNoResults, userInfo: [NSLocalizedDescriptionKey : String.errorCodeMessage.rssFeedNoResults]) as Error)
                        return
                    }
                    
                    completion(allResultsArray,nil)       
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
}


