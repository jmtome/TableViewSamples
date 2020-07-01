//
//  Item-Cell.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 30/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "NameLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "ValueLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let serialNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "SerialNumberLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        //label.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//
//
//    }
    
    fileprivate func setupLabels() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(serialNumberLabel)
        self.contentView.addSubview(valueLabel)
        
//        nameLabel.backgroundColor = .red
//        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
        //nameLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: 50).isActive = true 
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3).isActive = true
        serialNumberLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        serialNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        serialNumberLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        serialNumberLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
        serialNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true 
        valueLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabels()

    }
    
}
