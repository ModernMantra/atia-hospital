//
//  RequestListViewModel.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 18/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

public enum RequestListCellType: CaseIterable {
    case request
    case requestInfo
    
    var cellClass: AnyClass {
        switch self {
        case .request:
            return RequestTableViewCell.self
        case .requestInfo:
            return RequestInfoTableViewCell.self
        }
    }
    
}

enum RequestListViewModelLoading {
    case none
    case loading
    case completed(message: String)
    case failed(String)
}

enum RequestUpdateState {
    case none
    case done
}

protocol RequestListInput {
    func didSelected(event: Event)
    func loadRequests()
}

protocol RequestListOutput {
    var cellType: RequestListCellType { get }
    var badgeIcon: String { get }
    var requestList: [RequestListCellType : [Event]] { get }
    var state: Observable<RequestListViewModelLoading> { get }
    var requestUpdateState: Observable<RequestUpdateState> { get }
}

protocol RequestListViewModel: RequestListInput, RequestListOutput { }

// MARK: - Default implementation -

final class DefaultRequestListViewModel: RequestListViewModel {
    
    var badgeIcon: String {
        var count: Int = 0
        
        switch UserStateModel.shared.userType {
        case .admin:
            count = (self.requestList[self.cellType]?.count ?? 0)
        case .standard:
            count = (self.requestList[self.cellType]?.count ?? 0)
        }
        
        return (count == 0) ? "" : "\(count)"
    }
    var cellType: RequestListCellType {
        switch UserStateModel.shared.userType {
        case .admin:
            return .request
        case .standard:
            return .requestInfo
        }
    }
    let requestUpdateState: Observable<RequestUpdateState> = Observable(.none)
    var requestList = [RequestListCellType : [Event]]()
    let state: Observable<RequestListViewModelLoading> = Observable(.none)
    let useCase: AppointmentUseCase
    
    init(useCase: AppointmentUseCase) {
        self.useCase = useCase
    }
    
    func didSelected(event: Event) {
        if UserStateModel.shared.userType == .admin {
            self.useCase.updateAppointment(event, approved: !event.approved, completion: {
                self.requestUpdateState.value = .done
            })
        } else {
            self.requestUpdateState.value = .none
        }
    }
    
    func loadRequests() {
        self.state.value = .loading
        switch UserStateModel.shared.userType {
        case .admin:
            self.loadAdminRequests()
        case .standard:
            self.loadStandardRequests()
        }
    }
    
    fileprivate func loadAdminRequests() {
        self.useCase.getAllAppointments(completion: { result in
            switch result {
            case .failure(let error):
                let message: String = (error as? AppointmentError)?.localizedDescription ?? "Error"
                self.state.value = .failed(message)
            case .success(let events):
                self.requestList[self.cellType] = events
                self.state.value = .completed(message: "")
            }
        })
    }
    
    fileprivate func loadStandardRequests() {
        self.useCase.getApprovedAppointments(completion: { result in
            switch result {
            case .failure(let error):
                let message: String = (error as? AppointmentError)?.localizedDescription ?? "Error"
                self.state.value = .failed(message)
            case .success(let events):
                if (events.isEmpty) {
                    self.state.value = .completed(message: "No accepted appointments, check later.")
                } else {
                    self.requestList[self.cellType] = events
                    self.state.value = .completed(message: "There are \(events.count) accepted appointments")
                }
            }
        })
    }
    
}
