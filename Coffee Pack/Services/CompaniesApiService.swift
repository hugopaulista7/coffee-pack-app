//
//  ApiService.swift
//  Coffee Pack
//
//  Created by Hugo Paulista on 01/06/22.
//

import Foundation


class CompaniesApiService {
        
    func getData(_ path: String, completion: @escaping ([Company]) -> Void) {
        guard let url = URL(string: path) else { return }
        
        URLSession.shared.fetchData(at: url) { (result: Result<[Company], Error>) in
            switch result {
            case .success(let companies):
                completion(companies)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
}
