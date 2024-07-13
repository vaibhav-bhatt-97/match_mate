//
//  matchesRepository.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation
protocol MatchesRepository {
    func getMatches(results:Int, page: Int, completion: @escaping (Result<[Match], Error>) -> Void) 
}
