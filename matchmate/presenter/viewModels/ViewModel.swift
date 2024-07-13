//
//  viewModel.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var listOfMatches:[Match] = []
    @Published var errorFromGetMatches: String = ""
    let matchesRepository = MatchesRepositoryImpl()
    let getMatchesUseCase = GetMatchesUseCase()
    
    func getMatches(page:Int,results:Int){
        getMatchesUseCase.execute(matchesRepository:matchesRepository, page: page, results: results){result in
            switch result{
            case .success(let matches):
                self.listOfMatches = matches
                self.errorFromGetMatches = ""
            case .failure(let error):
                print("Error from get matches->\(error)")
                self.errorFromGetMatches = error.localizedDescription
                self.listOfMatches = []
            }
        }
    }
}
