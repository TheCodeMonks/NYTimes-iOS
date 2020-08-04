//
//  HTTPUtil.swift
//  NYTimes
//
//  Created by Waseem Akram on 04/08/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

class HTTPUtility {
    
    
    func fetch(using url: URL, completion: @escaping ((Data?)->Void)){
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil)
                return
            }
            
            guard let mime = response?.mimeType, mime == "text/html" else {
                completion(nil)
                return
            }
            
            if let data = data {
                completion(data)
                return
            }
            
            completion(nil)
        }
        task.resume()
    }
    
}
