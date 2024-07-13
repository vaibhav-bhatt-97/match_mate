//
//  utils.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
class Utils{
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
    func setDataToUserDefaults(key:String,value:Any){
        UserDefaults.standard.set(value, forKey: key)
    }
    func getDataFromUserDefaults(key:String, completion:(Any)->Void){
        if let savedValue = UserDefaults.standard.string(forKey: "YourKey") {
            debugPrint("Saved value: \(savedValue)")
            completion(savedValue)
        }
    }
}
