//
//  DetailsViewController.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 17/06/22.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var touristId: UILabel!
    @IBOutlet weak var touristName: UILabel!
    @IBOutlet weak var touristEmail: UILabel!
    @IBOutlet weak var touristLocation: UILabel!
    
    var touristData: TouristDatabase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTouristDetails()
    }
    
    func setTouristDetails() {
        if let tourist = touristData {
            touristId.text = String(tourist.id)
            touristName.text = tourist.name
            touristEmail.text = tourist.email
            touristLocation.text = tourist.location
        }else {
            let alertController = UIAlertController(title: "Error!", message: "Something went wrong", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
