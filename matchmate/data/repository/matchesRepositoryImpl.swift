//
//  matchesRepositoryImpl.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
class MatchesRepositoryImpl: MatchesRepository {
    let apiService = APIService()
    func getMatches(
        results:Int,
        page: Int,
        completion: @escaping (Result<[Match], Error>
        ) -> Void){
        apiService.makeRequest(
            endPoint: EndPoints.getMatches,
            httpMethod: .get,
            requestBody: nil,
            paths: [
                "results": results,
                "page": page
            ]
        ){result in
            switch result{
            case .success(let data):
                do{
                    let jsonData:[String:Any] = try JSONSerialization.jsonObject(with:data!,options:[]) as! [String : Any]
                    let response = try JSONDecoder().decode([Match].self,from: try JSONSerialization.data(withJSONObject:jsonData["results"],options:[]) )
                    completion(.success(response))
                }catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
