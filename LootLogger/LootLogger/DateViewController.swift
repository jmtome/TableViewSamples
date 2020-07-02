//
//  DateViewController.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 02/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    var item: Item! {
        didSet {
            dateLabel.text = "\(item.dateCreated)"
        }
    }
    

    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.preferredDatePickerStyle = .automatic
        return picker
    }()
    let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Date"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = "\(item.dateCreated)"
        datePicker.date = item.dateCreated
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
        print("dissappeared")
    }
    //aparentemente si cuando voy de un VC a otro tengo si la misma property, y la asigno, cambia en ambos el objeto
    //no entiendo porque esto ocurre asi...
    //segun pruebas que hice, creo que esto ocurre debido que lo que le paso ITEM es un objeto que es una clase, y por ende se pasaria por referencia creo... intente crear un objeto DATE en el VC anterior y pasarlo y modificarlo, utiliando el mismo nombre, pero no habia cambios.
    // incluso si le cambio el nombre al objeto en este VC, sigue funcionando el pasaje de datos, esto me hace pensar que indudablemente, se debe a que el item pasado es una referencia y no un objeto copiado,
    //esto no se bien si es porque Items y Itemstore son clases o porque es un array...
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        datePicker.addTarget(self, action: #selector(didChangeDatePicker(_:)), for: .valueChanged)
        self.view.backgroundColor = .white
        self.view.addSubview(dateLabel)
        dateLabel.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: datePicker.centerYAnchor, constant: -100).isActive = true
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func didChangeDatePicker(_ sender: UIDatePicker) {

        self.item.dateCreated = sender.date
        dateLabel.text = "\(sender.date)"
    }
    
    

}


