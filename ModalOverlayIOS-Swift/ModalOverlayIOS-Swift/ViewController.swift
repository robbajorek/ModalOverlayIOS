//
//  ViewController.swift
//  ModalOverlayIOS-Swift
//
//  Created by Rob Bajorek on 12/22/18.
//  Copyright © 2018 Rob Bajorek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// The text field that responds to a double-tap.
    @IBOutlet private weak var firstField: UITextField!
    /// A simple label that shows we received a message back from the overlay.
    @IBOutlet private weak var label: UILabel!
    /// The window that will appear over our existing one.
    private var overlayWindow: UIWindow?
    /// The window that contains the keyboard.
    /// This assumes that there _is_ a window with a keyboard.
    private var keyboardWindow: UIWindow? {
        // The window containing the keyboard always seems to be the last one.
        return UIApplication.shared.windows.last
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up gesture recognizer
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delegate = self
        firstField.addGestureRecognizer(doubleTapRecognizer)

        firstField.becomeFirstResponder()
    }

    @objc func handleDoubleTap() {
        print("Text field double tapped")

        // Prepare the overlay window
        guard let overlayFrame = view?.window?.frame else { return }
        overlayWindow = UIWindow(frame: overlayFrame)
        overlayWindow?.windowLevel = .alert
        let overlayVC = OverlayViewController.init(nibName: "OverlayViewController", bundle: nil)
        overlayWindow?.rootViewController = overlayVC
        overlayVC.delegate = self

        showOverlayWindow()
    }

    private func showMainWindow() {
        keyboardWindow?.isHidden = false
        UIWindow.animate(withDuration: 0.3,
                         animations: { [weak self] in
                            self?.overlayWindow?.alpha = 0.0
                            self?.keyboardWindow?.alpha = 1.0
            },
                         completion: { [weak self] _ in
                            self?.overlayWindow = nil
        })
    }

    private func showOverlayWindow() {
        overlayWindow?.alpha = 0.0
        overlayWindow?.isHidden = false
        UIWindow.animate(withDuration: 0.3,
                         animations: { [weak self] in
                            self?.overlayWindow?.alpha = 1.0
                            self?.keyboardWindow?.alpha = 0.0
            },
                         completion: { [weak self] _ in
                            self?.keyboardWindow?.isHidden = true
        })
    }
}

extension ViewController: OverlayViewControllerDelegate {
    func optionOneChosen() {
        let text = "Option 1 chosen"
        print(text)
        label.text = text
        showMainWindow()
    }

    func optionTwoChosen() {
        let text = "Option 2 chosen"
        print(text)
        label.text = text
        showMainWindow()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    // Our gesture recognizer clashes with UITextField's. Need to allow both
    //  to work simultaneously.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ViewController: UITextFieldDelegate {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disables the select/copy/etc. menu when tapping text
        DispatchQueue.main.async {
            UIMenuController.shared.isMenuVisible = false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
