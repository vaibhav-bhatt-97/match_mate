//
//  viewModel.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 12/07/24.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var listOfMatches:[Match] = []
    let matchesRepository = MatchesRepositoryImpl()
    let getMatchesUseCase = GetMatchesUseCase()
    
    func getMatches(){
        getMatchesUseCase.execute(matchesRepository:matchesRepository, page: 1, results:10){result in
                switch result{
                case .success(let matches):
                    self.listOfMatches = matches
                case .failure(let error):
                    print("Error from get matches->\(error)")
                    self.listOfMatches = []
                }
            }
    }
}
