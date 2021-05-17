//
//  FormCell.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import UIKit

struct FormCellModel: FormCellProtocol {
    var firstParam: UserParams
    
    var name: String
    var placeholder: String
}

enum UserParams {
    case name, gender, lifeStyle, height, weight, age, none
}

class FormCell: UITableViewCell, UITextFieldDelegate {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    private var user: User?
    private var params: UserParams = .none
    var picker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueTextField.delegate = self
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: FormCellModel, user: User) {
        nameLabel.text = model.name
        self.user = user
        valueTextField.placeholder = model.placeholder
        params = model.firstParam
        
        if [.gender, .lifeStyle].contains(model.firstParam) {
            createPicker(textFiled: valueTextField)
        }
    }
    
    
    func createPicker(textFiled: UITextField) {
        picker = UIPickerView()
        let tool = UIToolbar()
        tool.sizeToFit()
        let done = UIBarButtonItem(systemItem: .done)
        done.action = #selector(doneAction)
        done.target = self
        tool.setItems([done], animated: true)
        textFiled.inputAccessoryView = tool
        
        textFiled.inputView = picker
        picker.delegate = self
        picker.dataSource = self
    }
    
    @objc func doneAction() {
        if params == .lifeStyle {
            user?.lifeStyle = .trening1
        }
        endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let value = self.valueTextField.text {
            user?.set(params: params, value: value)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}


extension FormCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        LifeStyle.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LifeStyle.allCases[row].rawValue
    }
}
