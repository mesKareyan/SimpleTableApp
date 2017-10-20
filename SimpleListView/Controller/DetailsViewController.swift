//
//  DetailsViewController.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var packs:[Pack] = []
    var category: Category!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    
    struct Constants {
        private init() {}
        static let packCellID = "packCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        congigureUI()
        Api.getPacks(forID: category.id) { [weak self] result in
            switch result {
            case .sucsess(result: let data):
                let packsArr = data as! [Pack]
                self?.packs = packsArr.sorted(by: { (one, two) -> Bool in
                    one.id < two.id
                })
                self?.tableView.reloadData()
            case .fail:
                self?.showError()
            }
        }
    }
    
    private func congigureUI() {
        self.navigationItem.title = category.name
        topBarView.backgroundColor = UIColor.appLigtBlue
        tableView.backgroundColor = .clear
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    private func showError(){
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - TableView
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.packCellID) as! PackCell
        let pack = packs[indexPath.row]
        cell.configure(for: pack)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
}

