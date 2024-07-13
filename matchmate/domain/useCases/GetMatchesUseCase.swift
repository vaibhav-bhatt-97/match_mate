//
//  GetMatchesUseCase.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
class GetMatchesUseCase{
    func execute(matchesRepository: MatchesRepository,page: Int, results: Int, completion: @escaping (Result<[Match], Error>) -> Void){
        matchesRepository.getMatches(results: results,page: page){result in
            switch result{
            case .success(let matches):
                completion(.success(matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
