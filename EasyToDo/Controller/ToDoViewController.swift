//
//  ViewController.swift
//  EasyToDo
//
//  Created by Han Dole Kim on 5/7/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    
    var todos = [ToDo]()
    
    let uncheckedBox = UIImage(named: "selectBox40")
    let checkedBox = UIImage(named: "selectedBox40")
    
    @IBOutlet weak var newToDoTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    
    @IBAction func addNewToDo(_ sender: UITextField) {
        if newToDoTextField.text != "" {
            dismissKeyboard()
            
            if let newToDo = newToDoTextField.text {
                let todo = ToDo(context: PersistenceService.context)
                todo.title = newToDo
                todo.checked = false
                // SAVE to CoreData
                PersistenceService.saveContext()
                todos.append(todo)
            }
            
            // clear text field
            newToDoTextField.text = ""
            
            // update tableview
            let indexPath = IndexPath(row: todos.count - 1, section: 0)
            todoTableView.beginUpdates()
            todoTableView.insertRows(at: [indexPath], with: .automatic)
            todoTableView.endUpdates()
        } else {
            newToDoTextField.shake()
        }
    }
    
    @IBAction func editingDoneButtonTapped(_ sender: UITextField) {
        guard let cell = sender.nearestAncestor(ofType: ToDoTableViewCell.self) else {
            return
        }
        todos[(cell.indexPath?.item)!].title = sender.text
        dismissKeyboard()
    }
    
    @IBAction func editingEnd(_ sender: UITextField) {
        guard let cell = sender.nearestAncestor(ofType: ToDoTableViewCell.self) else {
            return
        }
        todos[(cell.indexPath?.item)!].title = sender.text
    }
    
    @IBAction func checkedButtonTapped(_ sender: UIButton) {
        guard let cell = sender.nearestAncestor(ofType: ToDoTableViewCell.self) else {
            return
        }
        let todo = todos[(cell.indexPath?.item)!]
        
        if todo.checked {
            todo.checked = !todo.checked
            cell.checkedButton.setImage(uncheckedBox, for: .normal)
            cell.todoTextField.textColor = .black
            cell.todoTextField.isEnabled = true
            cell.todoTextField.text = todo.title
        } else {
            todo.checked = !todo.checked
            cell.checkedButton.setImage(checkedBox, for: .normal)
            cell.todoTextField.textColor = .gray
            cell.todoTextField.isEnabled = false
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.todoTextField.text!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.todoTextField.attributedText = attributeString
        }
        
        // SAVE to CoreData
        PersistenceService.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide keyboard when other area touched
        self.hideKeyboardWhenTappedAround()
        
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do {
            let todos = try PersistenceService.context.fetch(fetchRequest)
            self.todos = todos
            self.todoTableView.reloadData()
        } catch {
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoTableViewCell
        if let todoName = todos[indexPath.item].title {
            cell.todoTextField.text = todoName
            if todos[indexPath.item].checked {
                cell.checkedButton.setImage(checkedBox, for: .normal)
                cell.todoTextField.textColor = .gray
                cell.todoTextField.isEnabled = false
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: cell.todoTextField.text!)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                cell.todoTextField.attributedText = attributeString
            } else {
                cell.checkedButton.setImage(uncheckedBox, for: .normal)
                cell.todoTextField.textColor = .black
                cell.todoTextField.isEnabled = true
            }
        }
        return cell
    }
    
    
    // TableView Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    // TableView Delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            PersistenceService.context.delete(todos[indexPath.item])
            
            todos.remove(at: indexPath.item)
            
            todoTableView.beginUpdates()
            todoTableView.deleteRows(at: [indexPath], with: .automatic)
            todoTableView.endUpdates()
        }
    }
    
    // TableView Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.todoTableView.deselectRow(at: indexPath, animated: true)
        self.todoTableView.cellForRow(at: indexPath)?.shake()
    }
}
