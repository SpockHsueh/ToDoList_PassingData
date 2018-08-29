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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationName
        self.textView.text = item
        setTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.text = item
        self.title = navigationName
    }
    

    @IBAction func saveTextInfo(_ sender: Any) {
        if item == nil {
            text = textView.text
            saveData()

        } else {
            text = textView.text
            changeData()
        }
        self.textView.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func saveData() {
        delegate?.didSaveData(data: text)
    }
    
    func changeData() {
        delegate?.didChangeData(data: text)
    }
    
    func setTextView() {
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
    }
}
