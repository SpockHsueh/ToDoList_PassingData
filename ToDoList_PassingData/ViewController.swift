//
//  ViewController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    
    var todoItem = [String]()
    var selectIndex: Int!
    
    // This is closure
    var datamodel: AddTaskController? = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailPage") as? AddTaskController
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        datamodel?.delegate = self
        
        todoListTableView.register(UINib(nibName: "TodoItemCell", bundle: nil), forCellReuseIdentifier: "TodoItemCell")
    }
    
    @IBAction func add(_ sender: Any) {
        guard let datamodel = datamodel else {
            return
        }
        datamodel.item = nil
        self.show(datamodel, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? AddTaskController else {
            return
        }
        if segue.identifier == "newItem" {
            detailVC.navigationName = "Add"
            detailVC.delegate = self
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as? TodoItemCell {
            cell.ItemLabel.text = todoItem[indexPath.row]
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func buttonPressed (button: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            selectIndex = button.tag
            if let datamodel = datamodel {
                datamodel.item = todoItem[button.tag]
                self.show(datamodel, sender: nil)
            }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        todoItem.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
}

extension ViewController: DataModelDelegate {
    
    func didChangeData(data: String?) {
        if let data = data {
            todoItem[selectIndex] = data
            todoListTableView.reloadData()
        }
    }
    
    func didSaveData(data: String?) {
        if let data = data {
            todoItem.append(data)
            todoListTableView.reloadData()
        }
    }
}

