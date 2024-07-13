//
//  utils.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
class utils{
    func getURLWithPath(url: String, paths: [String: Any]?) -> String {
        var pathAdjustedURL = url
        debugPrint("paths :- \(String(describing: paths)) - URL : \(url)")
        guard let paths = paths else {
            return url
        }
        paths.forEach { (key, value) in
            pathAdjustedURL = pathAdjustedURL.replacingOccurrences(of: "{\(key)}", with: "\(value)")
        }
        debugPrint("pathAdjustedURL--->>>\(pathAdjustedURL)")
        return pathAdjustedURL
    }
    
}
