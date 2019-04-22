//
//  SiteCell.swift
//
//  Created by Xcode User on 2019-03-07.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

//
//  Modify this to the app's need.
//  Note: This will be modified
//  depending on what we want to show
//  on the table.
//

//Modified By: Riya Shah
class SiteCell: UITableViewCell {

    let primaryLabel = UILabel();
    let secondaryLabel = UILabel();
    let thirdLabel = UILabel();
    var myimageView = UIImageView();
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 20)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .gray
        primaryLabel.layer.backgroundColor = UIColor.clear.cgColor
        
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .blue
        secondaryLabel.layer.backgroundColor = UIColor.clear.cgColor
        
        thirdLabel.textAlignment = .left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 16)
        thirdLabel.backgroundColor = .clear
        thirdLabel.textColor = .black
        thirdLabel.layer.backgroundColor = UIColor.clear.cgColor
        
        myimageView.image = UIImage(named:"someicon.png")
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(thirdLabel)
        contentView.addSubview(myimageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 5, y: 5, width: 460, height: 30)
        secondaryLabel.frame = CGRect(x: 85, y: 40, width: 250, height: 20)
        thirdLabel.frame = CGRect(x:190, y:75, width:460, height:16)
        
        myimageView.frame = CGRect(x: 10, y: 30, width: 60, height: 60)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
