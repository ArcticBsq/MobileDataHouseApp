//
//  ViewController.swift
//  MobileDataHouseApp
//
//  Created by Илья Москалев on 16.09.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Search pictures"
        self.hideKeyBoard()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        let text = searchTextField.text
        text.isEmptyOrWhitespace() ? showEmptyAlert() : showSearchScreen()
    }
    
    private func showEmptyAlert() {
        let ac = UIAlertController(title: "Empty search task", message: "Enter word to search", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac,animated: true)
    }
    
    private func showSearchScreen() {
        let text = searchTextField.text
        let vc = ModelBuilder.createFilterModule(searchTerm: text)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
}
// Check input string is not only made from whitespaces or nil
extension Optional where Wrapped == String {
    func isEmptyOrWhitespace() -> Bool {
        guard let target = self else { return true }
        
        if target.isEmpty {
            return true
        }
        return (target.trimmingCharacters(in: .whitespaces) == "")
    }
}

//MARK: Hide keyboard
extension UIViewController {
    func hideKeyBoard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
