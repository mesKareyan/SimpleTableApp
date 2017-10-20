//
//  CategoryCellTableViewCell.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

   
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.masksToBounds = false
        backView.layer.shadowOpacity = 0.4
        backView.layer.shadowRadius = 3.0
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.cornerRadius = 5.0
        backView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for category: Category) {
        nameLabel.text = category.name
        backView.backgroundColor = category.colorHex.hexColor
    }

}
