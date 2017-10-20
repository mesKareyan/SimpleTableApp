//
//  CategoriesListViewController.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class CategoriesListViewController: UIViewController {
    
    struct Constants {
        private init() {}
        static let categoryCellID = "categoryCell"
    }
    
    var categories: [Category] = []
    var selectedIndex: Int!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var topButtonsContainer: UIView!
    @IBOutlet weak var packsButton: UIButton!
    @IBOutlet weak var singleButton: UIButton!
    
    weak var selectedButton: UIButton! {
        didSet {
            UIView.animate(withDuration: 0.4) {
                oldValue?.viewWithTag(42)?.backgroundColor = .clear
                self.selectedButton.viewWithTag(42)?.backgroundColor = .appOrange
            }
        }
    }
    
    @IBAction func topButtonTapped(_ sender: UIButton) {
        self.selectedButton = sender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Api.getCategories { [weak self] result in
            switch result {
            case .sucsess(result: let data):
                let categoriesArr = data as! [Category]
                self?.categories = categoriesArr.sorted(by: { (one, two) -> Bool in
                    one.id > two.id
                })
                self?.tableView.reloadData()
            case .fail:
                self?.showError()
            }
        }
    }
    
    private func configureUI(){
        hideNavBar()
        topBarView.backgroundColor = UIColor.appLigtBlue
        topBarView.layer.masksToBounds = false
        topBarView.layer.shadowOpacity = 0.7
        topBarView.layer.shadowRadius = 2.0
        topBarView.layer.shadowColor = UIColor.lightGray.cgColor
        topBarView.layer.shadowOffset = CGSize(width: 0, height: 5)
        topBarView.clipsToBounds = false
        
        [packsButton, singleButton].forEach { button in
            guard let button = button else {return}
            let lineView = UIView(frame: CGRect(x: 0,
                                                y: button.frame.height - 3,
                                                width: button.frame.width,
                                                height: 3))
            button.addSubview(lineView)
            lineView.translatesAutoresizingMaskIntoConstraints = false
            lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            lineView.widthAnchor.constraint(equalTo: topButtonsContainer.widthAnchor, multiplier: 0.5).isActive = true
            lineView.bottomAnchor.constraint(equalTo: topButtonsContainer.bottomAnchor).isActive = true
            lineView.backgroundColor = UIColor.clear
            if button == packsButton {
                lineView.leftAnchor.constraint(equalTo: topButtonsContainer.leftAnchor).isActive = true
            } else {
                lineView.rightAnchor.constraint(equalTo: topButtonsContainer.rightAnchor).isActive = true
            }
            lineView.tag = 42
        }
        self.selectedButton = packsButton
    }
    
    private func showError(){
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let indentifier = segue.identifier else {
            return
        }
        if indentifier == "showDetails" {
            let controller = segue.destination as! DetailsViewController
            let cat = categories[selectedIndex]
            controller.category = categories[selectedIndex]
        }
    }
    
}


// MARK: - TableView
extension CategoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryCellID) as! CategoryCell
        let category = categories[indexPath.row]
        cell.configure(for: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedIndex = indexPath.row
        return indexPath
    }
    
}
