//
//  ProductTableViewCell.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 02/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func addButtonTapped(at index: Int)
    func removeButtonTapped(at index: Int)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelUnit: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    weak var delegate: ProductTableViewCellDelegate?
    var productIndex: Int!
    
    @IBAction func onTapButtonAdd(_ sender: Any) {
        self.delegate?.addButtonTapped(at: productIndex)
    }
    
    @IBAction func onTapButtonRemove(_ sender: Any) {
        self.delegate?.removeButtonTapped(at: productIndex)
    }
}
