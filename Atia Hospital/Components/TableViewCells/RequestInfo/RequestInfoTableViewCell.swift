//
//  RequestInfoTableViewCell.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 17/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

class RequestInfoTableViewCell: UITableViewCell {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var doctorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initCell(with model: Event) {
        self.doctorLbl.text = model.doctorName
        self.dateLbl.text = model.date
        self.containerView.layer.cornerRadius = 10
    }
    
}
