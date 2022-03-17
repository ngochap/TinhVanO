//
//  PageOneCLVCell.swift
//  traning1.1
//
//  Created by NgocHap on 16/03/2022.
//

import UIKit

class PageOneCLVCell: UICollectionViewCell {

    @IBOutlet weak var imgAvata: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescrip: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var checkView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imgAvata.layer.cornerRadius = imgAvata.frame.width / 2
       imgAvata.layer.borderWidth = 1
        imgAvata.layer.masksToBounds = false
        imgAvata.clipsToBounds = true
       imgAvata.layer.borderColor = UIColor.black.cgColor
        
        checkView.isHidden = true
        
    }

}
