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
    
    //UIToolbar
    let bottomToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        //toolbar.barStyle = .default

        return toolbar
    }()
    
    
    
    // Properties
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    
    
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
        
        let key = item.itemKey
        
        //if there is an associated image with the itemkey, display that image
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
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
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "star.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .vertical)
        image.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    fileprivate func setupMainStackView() {
        
        //Add stackview to VC's view
        self.view.addSubview(mainStackView)
        //Add views to stackview
        
        mainStackView.addArrangedSubview(nameStackView)
        mainStackView.addArrangedSubview(serialStackView)
        mainStackView.addArrangedSubview(valueStackView)
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(changeDateButton)
        mainStackView.addArrangedSubview(imageView)
        
//        imageView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -8).isActive = true
//
        
        //self.view.addSubview(bottomToolbar)
        changeDateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
        
        //Autolayout constraints for the main stack view to its superView
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  8).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        setupCrossedConstraints()
        
        //let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //there is a bug in uikit with uitoolbar that apparently if you dont setup the toolbar with a frame of at least 40x30
        // then there will be autolayout issues...

        //let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
        //let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(toolbar)
//        toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -50).isActive = true
//        toolbar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        toolbar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        mainStackView.bottomAnchor.constraint(equalTo: toolbar.topAnchor).isActive = true
//        //toolbar.topAnchor.constraint(equalTo: mainStackView.bottomAnchor).isActive = true
//        //this top anchor isnt necessary, for it is the same as the bottom anchor from the stackview
//        toolbar.setItems([camera], animated: true)
        
        
    }
    
    @objc fileprivate func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        //imagePicker.allowsEditing = true
        //imagePicker.showsCameraControls = true
        imagePicker.setEditing(true, animated: true)
        
        
        return imagePicker
    }
    
    @objc fileprivate func showDatePicker(_ sender: UIButton) {
        let vc = DateViewController()
        
        vc.item = self.item
        //self.modalPresentationStyle = .fullScreen
        self.definesPresentationContext = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func addPhoto(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker,animated: true, completion: nil)

            }
            alertController.addAction(cameraAction)
            
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender 
            self.present(imagePicker,animated: true, completion: nil)
            
            
        }
        alertController.addAction(photoLibraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        //using animated: true triggers a uikit bug about a constraint, its a bug, so its not important,
        //see https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
        //for further info
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        serialTextField.delegate = self
        valueTextField.delegate = self
        
        nameTextField.backgroundColor = .tertiarySystemFill
        serialTextField.backgroundColor = .tertiarySystemFill
        valueTextField.backgroundColor = .tertiarySystemFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        self.view.addGestureRecognizer(tap)
        let camera = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto(_:)))
        let delete = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(removeImage(_:)))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        toolbarItems = [camera,spacer, delete]
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.barStyle = .default

        //creo que lo mas coeherente es usar la propiedad toolbaraitems de el toolbar de el nav controller...
        //nose porque el libro hace hacerlo a mano
        
    }
    
    @objc private func removeImage(_ sender: UIBarButtonItem) {
        let key = item.itemKey
        
        imageView.image = nil
        imageStore.deleteImage(forKey: key)
        
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

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageStore.setImage(image, forkey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

//TODO: - add button to remove image
