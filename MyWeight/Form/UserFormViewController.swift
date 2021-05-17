//
//  UserFormViewController.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import UIKit


class UserFormViewController: UIViewController {
    var tableView: UITableView!
    var saveButton: UIButton!
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FormCell.nib, forCellReuseIdentifier: FormCell.id)
        tableView.register(FormTwoCell.nib, forCellReuseIdentifier: FormTwoCell.id)
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        saveButton = UIButton()
        view.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .red
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        tableView.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame.origin = CGPoint(x: 0, y: 0)
        let buttonHeight: CGFloat = 60
        let safeArea = additionalSafeAreaInsets
        saveButton.frame = CGRect(x: 30, y: view.frame.height - buttonHeight - 12 - safeArea.bottom, width: view.frame.width - 60, height: buttonHeight)
        tableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height - buttonHeight - 12 - 8 - safeArea.bottom)
    }
    
    @objc func didTapSave() {
        
        print("age - \(user.age)")
        print("gender - \(user.gender)")
        print("weight - \(user.weight)")
        print("lifeStyle - \(user.lifeStyle)")
        view.endEditing(true)
//        dismiss(animated: true)
    }
    
    var cells: [FormCellProtocol] = [FormCellModel(firstParam: .name, name: "Имя", placeholder: "Ваше имя"),
                                     FormCellTwoModel(secondParam: .weight, firstParam: .height,secondName: "Вес", secondPlaceHolder: "Кг", name: "Рост", placeholder: "см"),
                                     FormCellTwoModel(secondParam: .gender, firstParam: .age ,secondName: "Пол", secondPlaceHolder: "Ваш пол", name: "Возраст", placeholder: "Ваш возраст"),
                                     FormCellModel(firstParam: .lifeStyle, name: "Стиль жизни", placeholder: "Выбрать")]
}


extension UserFormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellCurrent = cells[indexPath.row]
        
        if let cellModel = cellCurrent as? FormCellTwoModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTwoCell.id, for: indexPath) as? FormTwoCell else {
                return UITableViewCell()
            }
            
            cell.setup(model: cellModel, user: user)
            return cell
        } else if let cellModel = cellCurrent as? FormCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FormCell.id, for: indexPath) as? FormCell else {
                return UITableViewCell()
            }
            
            cell.setup(model: cellModel, user: user)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
