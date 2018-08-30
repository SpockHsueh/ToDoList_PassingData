//
//  ViewController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

protocol getTableViewCell: class {
    func tableViewCellDidTap(_ sender: TodoItemCell)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var todoListTableView: UITableView!
    
    var todoItem = [String]()
    var selectIndex: Int!
    
    var dataModel: AddTaskController? = {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailPage") as? AddTaskController
        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        dataModel?.delegate = self
        
        todoListTableView.register(UINib(nibName: "TodoItemCell", bundle: nil), forCellReuseIdentifier: "TodoItemCell")
    }
    
    @IBAction func add(_ sender: Any) {
        dataModel?.item = nil
        dataModel?.navigationName = "Add"

        self.show(dataModel!, sender: nil)
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
            cell.cellDelegate = self
            cell.ItemLabel.text = todoItem[indexPath.row]
//            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func buttonPressed (button: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        selectIndex = button.tag
        dataModel!.item = todoItem[selectIndex]
        self.show(dataModel!, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        todoItem.remove(at: indexPath.row)
        self.todoListTableView.reloadData()
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

extension ViewController: getTableViewCell {
    
    func tableViewCellDidTap(_ sender: TodoItemCell) {
        
        guard let selectIndexPath = todoListTableView.indexPath(for: sender) else {
            return
        }
        selectIndex = selectIndexPath.row
        print(selectIndexPath.row)
    }
}





