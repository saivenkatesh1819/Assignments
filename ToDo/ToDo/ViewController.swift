//  ViewController.swift
//  ToDo
//
//  Created by Sai Voruganti on 5/19/25.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var todo: [ToDoItem] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var enterText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchTodos()
            }
   
    
    @IBAction func onButtonTapped(_ sender: Any) {
            guard let text = enterText.text, !text.isEmpty else { return }
            saveTodoItem(title: text)
            enterText.text = ""
            tableView.reloadData()


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        let todoItem = todo[indexPath.row]
        cell.titleLabel.text = todoItem.title

        if let date = todoItem.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            cell.dateLabel.text = formatter.string(from: date)
        }
        return cell
    }

    func fetchTodos() {
        let fetchRequest = ToDoItem.fetchRequest()
        let moc = CoreDataManager.shared.persistentContainer.viewContext
        do {
            todo = try    moc.fetch(fetchRequest)
        }catch {
            print("Unable to Fetch Data : \(error)")
        }
    }
    
    func saveTodoItem(title: String) {
        let moc = CoreDataManager.shared.persistentContainer.viewContext
        let todoItem = ToDoItem(context: moc)
        todoItem.title = title
        todoItem.date = Date()
        CoreDataManager.shared.saveContext()
        fetchTodos()
    }
}

