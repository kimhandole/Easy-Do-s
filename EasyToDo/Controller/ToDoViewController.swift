//
//  ViewController.swift
//  EasyToDo
//
//  Created by Han Dole Kim on 5/7/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController{
    
    var tasks = [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        return cell
    }
}
