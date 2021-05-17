//
//  ProfileViewController.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import UIKit


class ProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = DataStore().getUser() {
            print(user)
        } else {
            print("Not User")
            let vc = UserFormViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Text"
        return cell
    }
}
