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
        let name = Notification.Name("SaveInfo")
        NotificationCenter.default.addObserver(self, selector: #selector(addSaveInfo(noti:)), name: name, object: nil)
    }
    
    @objc func addSaveInfo(noti: Notification) {
        if let saveNotification = noti.userInfo, let saveInfo = saveNotification[NotificationInfo.message]{
            todoItem.append(saveInfo as! String)
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
            cell.editButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func buttonPressed (button: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addTaskVC = storyboard.instantiateViewController(withIdentifier: "detailPage")
        self.navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
}

