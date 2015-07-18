//
//  List.swift
//  MatchingGame
//
//  Created by Mac on 14-10-20.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

import UIKit
class ListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func numberOfSectionsInTableView(tableView: UITableView)->Int{
        return 1
    }
    func tableView(tableView: UITableView,numberOfRowsInSection section: Int) -> Int{
        return score.count
    }
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        var CellIdentifier:NSString="Cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier as String) as? UITableViewCell
        
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier as String)
            
        }
        cell!.textLabel?.text="\(score.objectAtIndex(indexPath.row))"
        return cell!
        
        
        
        
    }
    
}