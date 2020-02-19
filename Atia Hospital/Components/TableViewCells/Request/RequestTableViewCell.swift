//
//  RequestTableViewCell.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var doctorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var patientLbl: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var containerVIew: UIView!
    
    fileprivate var event: Event? {
        didSet { self.setupView() }
    }
    
    // MARK: - Lifecycle -

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initWith(event: Event) {
        self.event = event
    }
    
    // MARK: - Util -
    
    fileprivate func setupView() {
        self.containerVIew.layer.cornerRadius = 10
        self.doctorLbl.text = self.event?.doctorName
        self.dateLbl.text = self.event?.date
        self.patientLbl.text = self.event?.userName
        DispatchQueue.main.async {
            self.mainImageView.image = (self.event?.approved == true) ? UIImage(named: "approved") : UIImage(named: "declined")
            self.mainImageView.setNeedsDisplay()
        }
    }
    
}
