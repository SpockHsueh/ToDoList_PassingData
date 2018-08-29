//
//  AddTaskController.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class AddTaskController: UIViewController {
    
    @objc @IBOutlet weak dynamic var textView: UITextView!
    var navigationName: String!
    var item: String?
    var text: String?
    
    weak var delegate: ViewController?
    var completionHandler: ((_ data: String) -> Void)?

    
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

        self.textView.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    func setTextView() {
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.black.cgColor
    }
}
