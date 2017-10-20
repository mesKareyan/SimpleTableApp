//
//  PackCell.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class PackCell: UITableViewCell {
    
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
        backView.backgroundColor = UIColor.white
        nameLabel.textColor = UIColor.appLigtBlue
        iconImage.tintColor = .appLigtBlue
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for pack: Pack) {
        nameLabel.text = pack.name
        iconImage.image = iconImage.image?.withRenderingMode(.alwaysTemplate)
    }
    
}
