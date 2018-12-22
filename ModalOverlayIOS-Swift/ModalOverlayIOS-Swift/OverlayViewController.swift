//
//  OverlayViewController.swift
//  ModalOverlayIOS-Swift
//
//  Created by Rob Bajorek on 12/22/18.
//  Copyright © 2018 Rob Bajorek. All rights reserved.
//

import UIKit

protocol OverlayViewControllerDelegate: class {
    func optionOneChosen()
    func optionTwoChosen()
}

class OverlayViewController: UIViewController {
    @IBOutlet private weak var dismissButton: UIButton!
    weak var delegate: OverlayViewControllerDelegate?

    @IBAction private func optionOneTapped(_ sender: Any) {
     delegate?.optionOneChosen()
    }

    @IBAction private func optionTwoTapped(_ sender: Any) {
        delegate?.optionTwoChosen()
    }
}
