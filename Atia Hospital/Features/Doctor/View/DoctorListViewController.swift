//
//  DoctorListViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class DoctorListViewController: UIViewController, Alertable {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {  _ = DoctorListCellType.allCases.map({ self.tableView.register($0.cellClass) }) }
    }
    
    lazy var rightBarButton: UIButton = {
        let searchButton: UIButton = UIButton(type: .system)
        
        searchButton.setImage(UIImage(named: "logout")!, for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        searchButton.tintColor = UIColor(.textPrimary)
        searchButton.addTarget(self, action: #selector(self.rightBarButtonAction(_:)), for: .touchUpInside)
        
        return searchButton
    }()
    
    fileprivate var viewModel: DoctorListViewModel {
        return AppDIContainer().doctorListViewModel
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarItems()
        self.bind(to: self.viewModel)
    }
    
}

// MARK: - Util -

fileprivate extension DoctorListViewController {
    
    func setupNavigationBarItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBarButton)
    }
    
    @objc func rightBarButtonAction(_ sender: UIButton) {
        UserStateModel.shared.logout()
    }
    
    private func bind(to viewModel: DoctorListViewModel) {
        viewModel.routing.observe(on: self) { [weak self] in self?.handle($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showAlert(message: $0) }
    }
    
    func showAlert(message: String) {
        guard !message.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: message, severity: .error)
    }
    
}

// MARK: - View Model Delegation -

fileprivate extension DoctorListViewController {
    
    func handle(_ routing: DoctorListRouting) {
        switch routing {
        case .none:
            break
        case .details(let doctor):
            self.navigate(.doctorDetail(model: doctor))
        }
    }
    
}

// MARK: - Table view delegate and data source -

extension DoctorListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.doctors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctor = self.viewModel.doctors[indexPath.row]
        
        return tableView.dequeueReusableCell(of: DoctorTableViewCell.self, for: indexPath, configure: { configurableCell in
            configurableCell.initCell(with: doctor)
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doctor = self.viewModel.doctors[indexPath.row]
        self.navigate(.doctorDetail(model: doctor))
    }
    
}
