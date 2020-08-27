//
//  AddViewController.swift
//  HomeWorkToDo
//
//  Created by aluno on 21/08/20.
//  Copyright © 2020 Aluno. All rights reserved.
//

import UIKit

final class AddViewController : UIViewController {
   
    @IBOutlet weak var backButton: CircleButton!
    
    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var todoTextField: UITextField!
    
    @IBOutlet weak var typePicker: UIPickerView!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var saveButton: CircleButton!
    
    private var selectedType: TodoModel.ModelType = .onPriority{
        didSet{
            configureColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureColor(animated: false)
        configureTextField()
        configureButtons()
        configureTypePicker()
    }
}// end class
// MARK: Configuration extension
extension AddViewController {
    private func configureTextField(){
        todoTextField.borderStyle = .none
    }
    
    
    private func configureButtons(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .primaryActionTriggered)
    }
    
    private func configureTypePicker(){
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    
    private func configureColor(animated: Bool = true){
        
        if animated{
            UIView.animate(withDuration: 0.3){
                self.backButton.backgroundColor = self.selectedType.typeColor
                self.sideView.backgroundColor = self.selectedType.typeColor
                self.saveButton.backgroundColor = self.selectedType.typeColor
            }
        }else{
            self.backButton.backgroundColor = selectedType.typeColor
            self.sideView.backgroundColor = selectedType.typeColor
            self.saveButton.backgroundColor = selectedType.typeColor
        }
    }
    
}
//MARK: Action methods extension
extension AddViewController{
   
    @objc
    private func backButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func saveButtonPressed(){
        guard let text = todoTextField.text else {
            return
        }
        
        let model = TodoModel(type: selectedType, todoDescription: text, date: datePicker.date )
        TodoDataSource.shared.todos.append(model)
        TodoDataSource.shared.todosCollection.collectionDictionary.append(element: "\(text)", toValueOfKey: "\(selectedType)" )
        
        switch (selectedType.typeDescription){
            case "PRIORITY": TodoDataSource.shared.priorityArray.append("\(text)")
            case "HOME": TodoDataSource.shared.homeArray.append("\(text)")
            case "DAILY": TodoDataSource.shared.dailyArray.append("\(text)")
        default: break
        }
        
        TodoDataSource.shared.typeTodoArray.append("\(selectedType)")
        navigationController?.popViewController(animated: true)
    }
}

//MARK: The UIPickers delegate and datasource methods extension
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TodoModel.ModelType.allTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TodoModel.ModelType.allTypes[row].typeDescription
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = TodoModel.ModelType.allTypes[row]
    }
}

//MARK: Append extension for MyCollectionDictionary
extension Dictionary where Value: RangeReplaceableCollection {
    public mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) -> Value? {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
        return value
    }
}
