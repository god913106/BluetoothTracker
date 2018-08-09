//
//  BlueTableViewController.swift
//  BluetoothTracker
//
//  Created by 洋蔥胖 on 2018/8/9.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import CoreBluetooth

class BlueTableViewController: UITableViewController, CBCentralManagerDelegate {

    var centralManager: CBCentralManager?
    var names : [String] = []
    var RSSIs : [NSNumber] = []
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    //計時器 每10秒重新搜尋
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.startScan()
        })
    }
    
    
    //MARK: - CBCentralManager Code
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //檢查設備狀態有沒有開藍牙
        if central.state == .poweredOn {
            // Working
            startScan()
            startTimer()
        } else {
            // Not Working
            let alert = UIAlertController(title: "Bluetooth isn't working", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //開始搜尋藍牙
    func startScan() {
        //讓[]裡是空的
        names = []
        RSSIs = []
        tableView.reloadData()
         stopDiscovery()
//        centralManager?.stopScan()
        //withServices 可以指定要哪個設備，如果nil，就是找全部
        //For example you could look for only Bluetooth devices that are heart rate monitors or something.
        if(centralManager?.state == CBManagerState.poweredOn && centralManager?.isScanning == false) {
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
       
    }
    //停止搜尋藍牙設備
    func stopDiscovery() {
        if #available(iOS 9.0, *) {
            if (centralManager?.isScanning)! {
                centralManager?.stopScan()
            }
        } else {
            centralManager?.stopScan()
        }
    }
    
    //找完以後 didDiscover
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if let name = peripheral.name {
            names.append(name)
        }else {
            names.append(peripheral.identifier.uuidString)
        }
        RSSIs.append(RSSI)
        tableView.reloadData()
        
        
        
        
    }

    @IBAction func refreshTapped(_ sender: Any) {
        startScan()
        startTimer()
    }
    
    
    
    
    // MARK: - tableView dataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BlueTableViewCell{
            cell.nameLabel.text = names[indexPath.row]
            cell.rssiLabel.text = "RSSI: \(RSSIs[indexPath.row])"
            
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    

    




}
