//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 01/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // UILabels
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Name"
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)

        return label
    }()
    let serialLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Serial"
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)

        return label
    }()
    let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Value"
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Date"
        label.textAlignment = .center
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return label
    }()
    
    //UITextFields
    let nameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Write name here"
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        textField.borderStyle = .roundedRect
        return textField
    }()
    let serialTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Write serial here"
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        textField.borderStyle = .roundedRect
        return textField
    }()
    let valueTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Write value here"
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
   
    //UIStackViews
    let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        //si uso el distribution en .fillEqually va a ignorar el hugging creo que setie antes creo..
        stackView.spacing = 8
        return stackView
    }()
    
    let nameStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        //si uso el distribution en .fillEqually va a ignorar el hugging creo que setie antes creo..
        stackView.spacing = 8
        return stackView
    }()
    let serialStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        //si uso el distribution en .fillEqually va a ignorar el hugging creo que setie antes creo..
        stackView.spacing = 8
        return stackView
    }()
    let valueStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        //si uso el distribution en .fillEqually va a ignorar el hugging creo que setie antes creo..
        stackView.spacing = 8
        return stackView
    }()
    let changeDateButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Change Date", for: .normal)
        button.setTitleColor(.red, for: .normal)
        //button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // Properties
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    
    override func loadView() {
        super.loadView()
        //Setup main StackView
        setupLabelStackViews()
        setupMainStackView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = "\(item.valueInDollars)"
        dateLabel.text = "\(item.dateCreated)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text
        
        if let valueText = valueTextField.text, let value = NumberFormatter().number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    //no entiendo porque al cambiar el valor de item aca, cambia en el parent, la unica forma seria que haya un puntero haciendo referencia directa al itemstore... tendra que ver con el !? o con el storyboard segue?, quiza tenga que ver con que se llamen igual...
    
    
    
    
    fileprivate func setupLabelStackViews() {
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        serialStackView.addArrangedSubview(serialLabel)
        serialStackView.addArrangedSubview(serialTextField)
        valueStackView.addArrangedSubview(valueLabel)
        valueStackView.addArrangedSubview(valueTextField)
        
    }
    
    fileprivate func setupCrossedConstraints() {
        let constraint = NSLayoutConstraint(item: valueTextField,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: nameTextField,
                                            attribute: .leading,
                                            multiplier: 1,
                                            constant: 0)
        let constraint2 = NSLayoutConstraint(item: serialTextField,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: nameTextField,
                                            attribute: .leading,
                                            multiplier: 1,
                                            constant: 0)
        
        self.view.addConstraint(constraint)
        self.view.addConstraint(constraint2)

    }
    
    fileprivate func setupMainStackView() {
        
        //Add stackview to VC's view
        self.view.addSubview(mainStackView)
        //Add views to stackview
        
        mainStackView.addArrangedSubview(nameStackView)
        mainStackView.addArrangedSubview(serialStackView)
        mainStackView.addArrangedSubview(valueStackView)
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(changeDateButton)
        changeDateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
        
        //Autolayout constraints for the main stack view to its superView
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  8).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        setupCrossedConstraints()
        
    }
    
    @objc fileprivate func showDatePicker(_ sender: UIButton) {
        let vc = DateViewController()
        
        vc.item = self.item
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        serialTextField.delegate = self
        valueTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        self.view.addGestureRecognizer(tap)
        
        
    }
    

    
    @objc fileprivate func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
