//
//  ViewModel.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import Foundation
import CoreData

protocol DataViewModelDelegate {
    func dataRefreshSuccess()
    func dataFetchError(error: DataError)
}

class ViewModel: NSObject {
    let persistentContainer = NSPersistentContainer(name: "BirlaSoft_Assignment")
//    let context = AppDelegate.persistentContainer.viewContext
    private var apiServices: APIService!
    var dataViewModelDelegate: DataViewModelDelegate?
    var employeeData = [EmployeeDetails]()
    
    private var persistantDataList = [EmployeeDetails]() {
        didSet {
            setData()
        }
    }
    
    fileprivate func setData() {
        self.employeeData = persistantDataList
        self.dataViewModelDelegate?.dataRefreshSuccess()
    }
    
    public func getDataList() -> Void {
        APIService().getData{ (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.dataViewModelDelegate?.dataFetchError(error: error)
                
            case .success(let dataList):
                self.persistantDataList = dataList.data
//                try? self.saveData(data: dataList)
                self.dataViewModelDelegate?.dataRefreshSuccess()
            }
        }
    }
    
//    private func saveData(data: [EmployeeDetails]) throws {
//        let album = AlbumDatabase(context: self.context)
//        for item in data {
//            album.albumTitle = item.title
//            album.albumThumbnail = item.thumbnailUrl
//            album.albumId = item.albumId!
//            album.id = item.id!
//            album.imageUrl = item.url
//
//            self.context.insert(album)
//            try self.context.save()
//        }
//    }
    
}
