//
//  ToDoTableViewCell.swift
//  EasyToDo
//
//  Created by Han Dole Kim on 5/7/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var checkedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
