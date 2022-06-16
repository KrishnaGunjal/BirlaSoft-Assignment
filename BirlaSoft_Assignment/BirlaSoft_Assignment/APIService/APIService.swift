//
//  APIService.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import Foundation
import UIKit

enum DataError: Error {
    case networkError
    case parsing
    case invalidURI
}

class APIService {
    
    func getData(completion: @escaping(Result<Employee, DataError>) -> Void) {
        // The URI can be accepted from ViewModel if API has to be written more generic.
        // Same goes for API response parsing and model class array generation.
        let urlString = Constants.apiService

        guard let dataURI = URL(string: urlString) else {
            completion(.failure(.invalidURI))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: dataURI, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(.networkError))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let response = try decoder.decode(Employee.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(.parsing))
            }
        })

        dataTask.resume()
    }
    
}
