//
//  FormTwoCell.swift
//  MyWeight
//
//  Created by Astemir Shibzuhov on 5/17/21.
//

import UIKit

protocol FormCellProtocol {
    var name: String { get }
    var placeholder: String { get }
    var firstParam: UserParams { get }
}

protocol FormCellTwoProtocol: FormCellProtocol {
    var secondName: String { get }
    var secondPlaceHolder: String { get }
    var secondParam: UserParams { get }
}


struct FormCellTwoModel: FormCellTwoProtocol {
    var secondParam: UserParams
    
    var firstParam: UserParams
    
    var secondName: String
    
    var secondPlaceHolder: String
    
    var name: String
    
    var placeholder: String
}

class FormTwoCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondValueTextField: UITextField!
    @IBOutlet weak var firstValueTextField: UITextField!
    var user: User?
    var firstParam: UserParams = .none
    var secondParam: UserParams = .none
    var picker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondValueTextField.delegate = self
        firstValueTextField.delegate = self
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: FormCellTwoModel, user: User) {
        self.user = user
        secondName.text = model.secondName
        firstName.text = model.name
        secondValueTextField.placeholder = model.secondPlaceHolder
        firstValueTextField.placeholder = model.placeholder
        firstParam = model.firstParam
        secondParam = model.secondParam
        if [.gender, .lifeStyle].contains(model.firstParam) {
            createPicker(textFiled: firstValueTextField)
        }
        
        if [.gender, .lifeStyle].contains(model.secondParam) {
            createPicker(textFiled: secondValueTextField)
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
        if firstParam == .gender || secondParam == .gender {
            user?.gender = Gender.allCases[picker.selectedRow(inComponent: 0)]
        }
        endEditing(true)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else {
            return
        }
        
        if textField === secondValueTextField {
            user?.set(params: secondParam, value: value)
        } else {
            user?.set(params: firstParam, value: value)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

extension FormTwoCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if firstParam == .gender || secondParam == .gender {
            return Gender.allCases.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].rawValue
    }
}
