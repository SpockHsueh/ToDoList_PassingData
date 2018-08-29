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
        datamodel?.loadViewIfNeeded()
        datamodel?.addObserver(self, forKeyPath: "textView.text", options: [.old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print(change!)
        if change![NSKeyValueChangeKey.oldKey] as! String != ""{
                let data = change![NSKeyValueChangeKey.oldKey]
            if selectIndex == nil {
                todoItem.append(data as! String)
            } else {
                todoItem[selectIndex] = data as! String
                selectIndex = nil
            }
                self.todoListTableView.reloadData()
        }
    }
    
    @IBAction func add(_ sender: Any) {

        datamodel!.item = nil
        datamodel?.navigationName = "Add"

        self.show(datamodel!, sender: nil)
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
            datamodel!.item = todoItem[button.tag]
            datamodel?.navigationName = "Edit"
 
            self.show(datamodel!, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        todoItem.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
}

