//
//  AddTaskController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class AddTaskController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var navigationName: String!
    var item: String?
    var text: String?
    
    weak var delegate: ViewController?
    // keep closure to property from VC1
    var completionHandler: ((_ data: String) -> Void)?
    
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
        super.viewWillAppear(animated)
        self.title = navigationName
        self.textView.text = item
    }
    
    @IBAction func saveTextInfo(_ sender: Any) {
        if item == nil {
            if let text = textView.text {
                completionHandler!(text)
            }
            
        } else {
            if let text = textView.text {
                completionHandler!(text)
            }
        }
        self.textView.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func setTextView() {
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
    }
}
