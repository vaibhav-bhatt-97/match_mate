//
//  utils.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 12/07/24.
//

import Foundation
class utils{
    func getURLWithPath(URL:String,paths:Dictionary<String, Any>?) -> String {
    var pathAdjustedURL:String=URL
        print("paths :- \(String(describing: paths)) - URL : \(URL)")
        guard let paths else{
            return URL
        }
        paths.forEach{ (key,value) in
           pathAdjustedURL = URL.replacingOccurrences(of: "{\(key)}", with: "\(value)")
        }
        return pathAdjustedURL
    }

}
