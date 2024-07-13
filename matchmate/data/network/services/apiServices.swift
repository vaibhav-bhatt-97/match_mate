//
//  apiServices.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//
import Foundation
import Alamofire

class APIService{
    func makeRequest(
        endPoint: String,
        httpMethod: HTTPMethod,
        requestBody: Parameters?,
        paths: Dictionary<String, Any>?,
        queryParameter: Dictionary<String, Any>? = [:],
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        
        let requestUrl = Utils().getURLWithPath(url: EndPoints.baseURL + endPoint, paths: paths ?? [:])
        debugPrint("Endpoint:- \(requestUrl)")
        AF.request(
            requestUrl,
            method: httpMethod,
            parameters: requestBody ?? nil,
            encoding: JSONEncoding.default
        ).response { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
