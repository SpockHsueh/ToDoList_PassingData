//
//  TodoItemCell.swift
//  ToDoList_PassingData
//
//  Created by Spoke on 2018/8/28.
//  Copyright © 2018年 Spoke. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell {
    
    @IBOutlet weak var ItemLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    weak var cellDelegate: getTableViewCell?
    
    @IBAction func editPressed(_ sender: Any) {
        cellDelegate?.tableViewCellDidTap(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
