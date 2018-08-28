//
//  AddTaskController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class AddTaskController: UIViewController {
    
    var navigationName: String!
    
    @IBOutlet weak var textView: UITextView!
    
    struct NotificationInfo {
        static let message = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationName
        setTextView()
    }
    
    

    
    @IBAction func saveTextInfo(_ sender: Any) {
        NotificationCenter.default.post(name: .didSave, object: nil, userInfo: [NotificationInfo.message: textView.text])
        navigationController?.popViewController(animated: true)
    }
    
    func setTextView() {
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
    }
    

}

extension Notification.Name {
    static let didSave = Notification.Name("SaveInfo")
}
