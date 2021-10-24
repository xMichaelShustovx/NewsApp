//
//  CacheManager.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url: String, _ imageData: Data) {
     
        imageDictionary[url] = imageData
        
    }
    
    static func retrieveData(_ url: String) -> Data? {
        
        return imageDictionary[url]
        
    }
}
