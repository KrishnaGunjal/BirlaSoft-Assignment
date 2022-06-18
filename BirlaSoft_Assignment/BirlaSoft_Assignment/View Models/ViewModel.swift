//
//  ViewModel.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import Foundation
import CoreData
import UIKit

protocol DataViewModelDelegate {
    func dataRefreshSuccess()
    func dataFetchError(error: DataError)
}

class ViewModel: NSObject {
    static let persistentContainer = NSPersistentContainer(name: Constants.managedObjectModel)
    let context = ((UIApplication.shared.delegate) as!  AppDelegate).persistentContainer.viewContext
    private var apiServices: APIService!
    var dataViewModelDelegate: DataViewModelDelegate?
    
    public func getDataList() -> Void {
        APIService().getData{ (result) in
            switch result {
            case .failure(let error):
                self.dataViewModelDelegate?.dataFetchError(error: error)
                
            case .success(let dataList):
                try? self.saveData(data: dataList.data)
                self.dataViewModelDelegate?.dataRefreshSuccess()
            }
        }
    }
    
    private func saveData(data: [TouristDetails]) throws {
        for item in data {
            let tourist = TouristDatabase(context: self.context)
            tourist.id = Int64(item.id)
            tourist.name = item.touristName
            tourist.email = item.touristEmail
            tourist.createdDate = item.createdat
            tourist.location = item.touristLocation
            
            print(item)
            
            self.context.insert(tourist)
            do{
                try context.save()
            } catch let error as NSError {
                print("Could not save\(error)")
            }
        }
        
    }
    
}
