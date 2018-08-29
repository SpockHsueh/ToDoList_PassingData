//
//  AddTaskController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

protocol DataModelDelegate: AnyObject {
    func didSaveData(data: String?)
    func didChangeData(data: String?)
}

class AddTaskController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var navigationName: String!
    var item: String?
    var text: String?
    
    weak var delegate: DataModelDelegate?
    
    struct NotificationInfo {
        static let message = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationName
        self.textView.text = item
        setTextView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.textView.text = item
    }

    
    @IBAction func saveTextInfo(_ sender: Any) {
        if item == nil {
            saveData()
        } else {
            changeData()
        }
        self.textView.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        text = textView.text
        delegate?.didSaveData(data: text)
    }
    
    func changeData() {
        text = textView.text
        delegate?.didChangeData(data: text)
        
    }
    
    func setTextView() {
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
    }
}

extension Notification.Name {
    static let didSave = Notification.Name("SaveInfo")
    static let didChange = Notification.Name("ChangeInfo")
}
