//
//  ViewController.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    static let persistentContainer = NSPersistentContainer(name: "BirlaSoft_Assignment")
    let context = ((UIApplication.shared.delegate) as!  AppDelegate).persistentContainer.viewContext
    let viewModel = ViewModel()
    var touristDetails = [TouristDatabase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dataViewModelDelegate = self
        tableView.register(UINib(nibName: reuseIdentifiers.dataCell, bundle: nil), forCellReuseIdentifier: reuseIdentifiers.dataCell)
        self.CheckForLocalData()
    }
    
    func CheckForLocalData() {
        let Count = try? context.count(for: NSFetchRequest(entityName: "TouristDatabase"))
        if (Count == 0) {
            viewModel.getDataList()
        }else {
            self.touristDetails = (self.fetchData() as? [TouristDatabase])!
        }
        
    }
}

extension ViewController: DataViewModelDelegate {
    func dataFetchError(error: DataError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error!", message: "Something went wrong", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func dataRefreshSuccess() {
        DispatchQueue.main.async {
            self.touristDetails = (self.fetchData() as? [TouristDatabase])!
            self.tableView.reloadData()
        }
    }
    
    func fetchData() -> [Any]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TouristDatabase")
        
        do{
            let result = try self.context.fetch(fetchRequest)
            print(touristDetails)
            return result
            
        }catch{
            print("Error while fetching data from Database.")
        }
        return nil
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.touristDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers.dataCell) as! EmployeeCell
        let employeeData = self.touristDetails[indexPath.row]
        cell.employeeName.text = employeeData.name
        cell.employeeEmailId.text = employeeData.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let selectedEmployeeDetails = self.touristDetails[indexPath.row]
        detailController.touristData = selectedEmployeeDetails
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

