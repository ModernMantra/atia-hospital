//
//  DoctorDetailViewController.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 16/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Firebase

class DoctorDetailViewController: UIViewController, Alertable {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var appointmentBttn: RoundedFilledButton!
    
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var dateTxtField: UITextField! {
        didSet { self.setDatePicker() }
    }
    
    fileprivate var viewModel: DoctorDetailViewModel!
    var model: Doctor? {
        didSet {
            guard let doctor = self.model else { return }
            let appUseCase = AppDIContainer().appointmentUseCase
            let doctorUseCase = AppDIContainer().doctorUseCases
            
            self.viewModel = DefaultDoctorViewModel(
                doctor: doctor,
                appointmentUseCases: appUseCase,
                doctorUseCases: doctorUseCase
            )
        }
    }
    let datePicker = UIDatePicker()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
        self.setupView()
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        self.addToolBar(textField: self.dateTxtField)
        self.dateTxtField.inputView = self.datePicker
    }
    
    override func doneDatePicker(){
        super.doneDatePicker()
        self.dateTxtField.text = self.viewModel.getDateFormatted(for: self.datePicker.date)
    }

    override func cancelDatePicker(){
        super.cancelDatePicker()
    }
    
    // MARK: - Bttn Actions -
    
    @IBAction func bookAppointmentAction(_ sender: Any) {
        guard let _ = self.model, let date = dateTxtField.text else {
            return
        }
        self.viewModel.bookAppointment(for: date)
    }
    
}

// MARK: - Util -

fileprivate extension DoctorDetailViewController {
    
    func setupView() {
        guard let _ = self.model else { return }
        self.nameLbl.text = self.viewModel.screenTitle
        self.mainContainerView.layer.cornerRadius = 30
        self.nameContainerView.layer.cornerRadius = 30
    }
    
    func bind(to viewModel: DoctorDetailViewModel) {
        viewModel.state.observe(on: self) { [weak self] in self?.handleBooking(state: $0)}
    }
    
}

// MARK: - State Handling -

fileprivate extension DoctorDetailViewController {
    
    func handleBooking(state: AppointmentBookingStatus) {
        switch state {
        case .failed(let error):
            self.showError(error.localizedDescription)
        case .success(let message):
            self.showSuccess(message: message)
        case .none:
            break
        }
    }
    
    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: NSLocalizedString("Error", comment: ""), message: error, severity: .error)
    }
    
    func showSuccess(message: String) {
        guard !message.isEmpty else { return }
        showAlert(message: message, severity: .success)
    }
    
}
