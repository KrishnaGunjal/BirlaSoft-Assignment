//
//  EmployeeCell.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 16/06/22.
//

import UIKit

class EmployeeCell: UITableViewCell {
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeEmailId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
