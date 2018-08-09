//
//  BlueTableViewController.swift
//  BluetoothTracker
//
//  Created by 洋蔥胖 on 2018/8/9.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class BlueTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func refreshTapped(_ sender: Any) {
        
    }
    
    //For example you could look for only Bluetooth devices that are heart rate monitors or something.
    //如果要找全部設備，就是輸入nil
    
    
    
    // MARK: - tableView dataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BlueTableViewCell{
            cell.nameLabel.text = "外圍設備：測試中"
            cell.rssiLabel.text = "接收強度：-28"
            
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    

    




}
