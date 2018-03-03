//
//  TableViewAbstraction.swift
//  IpadNotesProject
//
//  Created by Matthew Harrilal on 3/3/18.
//  Copyright © 2018 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

typealias TableViewCellCallBack  = (UITableView, IndexPath) -> UITableViewCell

class TableViewDataSource<Items>: NSObject, UITableViewDataSource {
    
    var items = [Items]()
    
    var configureCell: TableViewCellCallBack?
    
    init(items: [Items]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configureCell = configureCell else {
            precondition(false, "Please provide a cell to be configured")
        }
        return configureCell(tableView, indexPath)
    }
}
