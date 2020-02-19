//
//  DoctorTableViewCell.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {
    
    // MARK: - Outlets -

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate var model: Doctor? {
        didSet { self.setupView() }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Util -
    
    func initCell(with model: Doctor) {
        self.model = model
    }
    
    func setupView() {
        guard let model = self.model else { return }
        self.containerView.layer.cornerRadius = 10
        self.nameLbl.text = "\(model.firstName) \(model.lastName)"
        self.emailLbl.text = model.email
    }
    
}
