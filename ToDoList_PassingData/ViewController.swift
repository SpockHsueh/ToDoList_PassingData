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

    
    struct NotificationInfo {
        static let message = ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        
        todoListTableView.register(UINib(nibName: "TodoItemCell", bundle: nil), forCellReuseIdentifier: "TodoItemCell")
        
        addNotification()
    }
    
    func addNotification() {
        let saveName = Notification.Name("SaveInfo")
        let changeName = Notification.Name("ChangeInfo")
        NotificationCenter.default.addObserver(self, selector: #selector(addSaveInfo(noti:)), name: saveName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addChangeInfo(noti:)), name: changeName, object: nil)

    }
    
    @objc func addSaveInfo(noti: Notification) {
        if let saveNotification = noti.userInfo, let saveInfo = saveNotification[NotificationInfo.message]{
            todoItem.append(saveInfo as! String)
            print(todoItem)
            todoListTableView.reloadData()
        }
    }
    
    @objc func addChangeInfo(noti: Notification) {
        if let saveNotification = noti.userInfo, let changeInfo = saveNotification[NotificationInfo.message]{
            todoItem[selectIndex] = changeInfo as! String
            todoListTableView.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? AddTaskController else {
            return
        }
        
        if segue.identifier == "newItem" {
            detailVC.navigationName = "Add"
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
        if let addTaskVC = storyboard.instantiateViewController(withIdentifier: "detailPage") as? AddTaskController {
            selectIndex = button.tag
            addTaskVC.item = todoItem[button.tag]
            self.navigationController?.pushViewController(addTaskVC, animated: true)
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

