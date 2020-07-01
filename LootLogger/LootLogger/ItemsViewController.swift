//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 20/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    // Items Store Property
    var itemStore: ItemStore!
    var dummyItem: Item = Item(name: "Sesquipedalian MacBook Pro with Psychic Transference", valueInDollars: 0, serialNumber: "No Serial!", isFavorite: nil)
    var dummyFav: Item = Item(name: "No favs!", valueInDollars: 0, serialNumber: "No Serial!", isFavorite: nil)
    var favStore: ItemStore!
    var isShowingFavorites: Bool = false
    
    // Visual code
    var headerView: UIView! = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .systemTeal
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        return button
    }()
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        return button
    }()
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    

    // View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderView()
        if itemStore.allItems.isEmpty {
            itemStore.allItems.append(dummyItem)
        }
        if favStore.allItems.isEmpty {
            favStore.allItems.append(dummyFav)
        }
  
//        tableView.estimatedRowHeight = 65
        
        
        
    }
    
    fileprivate func setHeaderView() {
        
        // add headerView to tableView's header view
        tableView.tableHeaderView = headerView
        // set headerView's constraints, note: if top anchor is not constrained to safeAreaLayout's top constraint, it wont stay fixed on top when the TV is scrolled.
        
        headerView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
        
        //Fix header height spacing problem with layoutifneeded
        guard let hV = tableView.tableHeaderView else { return }
        hV.layoutIfNeeded()
        let header = tableView.tableHeaderView
        tableView.tableHeaderView = header
        
        //add "add" button to top right side of header view
        headerView.addSubview(addButton)
        addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        addButton.addTarget(self, action: #selector(addNewItem(_:)), for: .touchUpInside)
        //add "edit" button to top left side of header view
        headerView.addSubview(editButton)
        editButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        editButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        editButton.addTarget(self, action: #selector(toggleEditingMode(_:)), for: .touchUpInside)
        //add favorites button
        headerView.addSubview(filterButton)
        filterButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        filterButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        filterButton.addTarget(self, action: #selector(showFavorites(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func showFavorites(_ sender: UIButton) {
        if !isShowingFavorites {
            filterButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            print("star is filled\n -")
            favStore.allItems = itemStore.allItems.filter { $0.isFavorite }
            print(favStore.allItems.count)
            for item in favStore.allItems {
                print(item.name)
            }
        } else {
            filterButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        //TODO: - Probably I should add a delegate or observer to the favourite properties and see if they change before doing
        //the re-set i do here of the favStore, because it is essentially wasting resources.
        
        
        
        isShowingFavorites.toggle()

        self.tableView.reloadData()
    }
    
    //TODO: - Last todo, it works, but now i have to ensure deletion and other things. bye
    
    @objc fileprivate func addNewItem(_ sender: UIButton) {
        print("pepe")
        
        
        if itemStore.allItems[0] == dummyItem {
            itemStore.allItems.remove(at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .left)
        }
        
        
        
    }
    
    @objc fileprivate func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return itemStore.allItems.isEmpty ? 1 : itemStore.allItems.count
        print(favStore.allItems.count)
        print("pepe")
        print(itemStore.allItems.count)
        return isShowingFavorites ? favStore.allItems.count : itemStore.allItems.count
        //return isShowingFavorites ? favStore.allItems.count : itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !(itemStore.allItems[0] == dummyItem)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")

        print(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item: Item = isShowingFavorites ? favStore.allItems[indexPath.row] : itemStore.allItems[indexPath.row]

        //item = itemStore.allItems[indexPath.row]
        print(item.isFavorite)
        
        cell.nameLabel.text = item.isFavorite ? ("\(item.name) ⭐️") : item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        cell.valueLabel.textColor = item.valueInDollars <= 50 ? #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // quizas hubiera sido menos costoso utilizar tableview.rowHeight y tableview.estimatedRowHeight en el viewDidLoad en vez de estos metodos delegate.
    //para que ande el automaticdimension es importante que todos los constraint esten puestos
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favouriteAction = UIContextualAction(style: .normal, title: "⭐️") { (_, _, completionHandler) in
            
            let item = self.itemStore.allItems[indexPath.row]
            item.isFavorite.toggle()
            
            self.tableView.reloadData()
            
            completionHandler(true)
        }
        favouriteAction.backgroundColor = .systemPurple
        let configuration = UISwipeActionsConfiguration(actions: [favouriteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    //TODO: - It's pretty probable that I should use delegate methods here to modify the tableview datasource instead of manually modifying them
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in

            // 1. remove object from your array
            self.itemStore.allItems.remove(at: indexPath.row)
            // 2. reload the table, otherwise you get an index out of bounds crash
            //self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if self.itemStore.allItems.isEmpty {
                self.itemStore.allItems.append(self.dummyItem)
                self.tableView.insertRows(at: [indexPath], with: .none)
            }
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemOrange
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

    
  
    

    
     //Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            let item = itemStore.allItems[indexPath.row]
//            itemStore.removeItem(item)
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    // ver uicontextualaction tableview
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
