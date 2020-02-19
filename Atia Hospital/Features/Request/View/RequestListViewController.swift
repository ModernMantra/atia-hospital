//
//  RequestListViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class RequestListViewController: UIViewController, Alertable, Loadable {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet { _ = RequestListCellType.allCases.map({ self.tableView.register($0.cellClass) }) }
    }
    
    lazy var rightBarButton: UIButton = {
        let searchButton: UIButton = UIButton(type: .system)
        
        searchButton.setImage(UIImage(named: "logout")!, for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        searchButton.tintColor = UIColor(.textPrimary)
        searchButton.addTarget(self, action: #selector(self.rightBarButtonAction(_:)), for: .touchUpInside)
        
        return searchButton
    }()
    
    fileprivate lazy var viewModel: RequestListViewModel = {
        return AppDIContainer().requestListViewModel
    }()
    
    let activityView = UIActivityIndicatorView(style: .large)

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarItems()
        self.bind(to: self.viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.loadRequests()
    }
    
}

// MARK: - Util -

fileprivate extension RequestListViewController {
    
    func setupNavigationBarItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightBarButton)
    }
    
    @objc func rightBarButtonAction(_ sender: UIButton) {
        UserStateModel.shared.logout()
    }
    
    func bind(to viewModel: RequestListViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.handleRequestLoading(state: $0) }
        viewModel.requestUpdateState.observe(on: self) { [weak self] in self?.handleRequestUpdate(state: $0) }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tabBarItem.badgeValue = "\(self.viewModel.badgeIcon)"
        }
    }
    
}

// MARK: - Handling State -

fileprivate extension RequestListViewController {
    
    func handleRequestLoading(state: RequestListViewModelLoading) {
        switch state {
        case .none:
            break
        case .loading:
            self.showLoading(activityView: self.activityView)
        case .completed(let message):
            if (!message.isEmpty) {
                self.showAlert(message: message, severity: .info)
            }
            self.removeLoading(activityView: self.activityView)
            self.reloadData()
        case .failed(let message):
            self.showAlert(message: message, severity: .error)
            self.removeLoading(activityView: self.activityView)
            self.reloadData()
        }
    }
    
    func handleRequestUpdate(state: RequestUpdateState) {
        switch state {
        case .none:
            break
        case .done:
            self.showAlert(message: "Appointment updated", severity: .success)
            self.reloadData()
        }
    }
    
}

// MARK: - Delegate -

extension RequestListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.requestList[self.viewModel.cellType]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.viewModel.cellType {
        case .request:
            return tableView.dequeueReusableCell(of: RequestTableViewCell.self, for: indexPath, configure: { configurableCell in
                if let event = self.viewModel.requestList[self.viewModel.cellType]?[indexPath.row] {
                    configurableCell.initWith(event: event)
                }
            })
        case .requestInfo:
            return tableView.dequeueReusableCell(of: RequestInfoTableViewCell.self, for: indexPath, configure: { configurableCell in
                if let event = self.viewModel.requestList[self.viewModel.cellType]?[indexPath.row] {
                    configurableCell.initCell(with: event)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = self.viewModel.requestList[self.viewModel.cellType]?[indexPath.row] else { return }
        self.viewModel.didSelected(event: event)
    }
    
}
