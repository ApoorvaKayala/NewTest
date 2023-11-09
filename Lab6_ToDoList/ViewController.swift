//
//  ViewController.swift
//  Lab6_ToDoList
//
//  Created by Apoorva Kayala.
//

import UIKit

//ViewController is a subclass of UIViewController, UITableViewDelegate and UITableViewDataSource to manage the table view.
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //This is an array to store the to do items.
    var toDoList = ["Item 1", "Item 2", "Item 3"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //savedTodoItems is an array that gets stored in the phones memory to attain Data persistance.
        if let savedToDoItems = UserDefaults.standard.array(forKey: "toDoItems") as? [String] {
                    toDoList = savedToDoItems
                }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyList")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //This function defines the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return toDoList.count //Number of rows in table view is equal to the number of elements in the array 'toDoList'.
    }
    
    //This function defines the functionality of swipping a row in the table view.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->
    UITableViewCell.EditingStyle{
        return .delete //A row that is swipped towards the left is said to be deleted.
    }
    
    //The values of the array 'toDoList' are being assigned to the cells of the table view in this function.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let todo = toDoList[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel?.text = todo
        
        return cell
    }
    
    //When a row is deleted from the table view that item is also deleted from the array 'toDoList'.
    func tableView(_ tableView: UITableView, commit editingStyle:
    UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveToDoList()
            tableView.reloadData()
        }
        
    }
    
    //This function displays a 'Add Item' text field and allows user to add a new item to the 'toDoList'.
    @IBAction func addNewItem(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField)in
            textField.placeholder = "New Item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let toDoItem = alert.textFields?.first?.text else{
                return
            }
            
            self.toDoList.append(toDoItem)
            self.saveToDoList()
            self.tableView.reloadData()
            
        }))
        present(alert,animated: true)
        
    }
    
    //This function saves the items in the array to the phones memory every time an item is added or deleted.
    func saveToDoList() {
            UserDefaults.standard.set(toDoList, forKey: "toDoItems")
        }
    
}
