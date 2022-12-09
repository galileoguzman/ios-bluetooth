//
//  BluetoothViewModel.swift
//  CBSample
//
//  Created by Galileo Guzman on 08/12/22.
//

import Foundation
import CoreBluetooth

class BluetoothViewModel: NSObject {
    
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    
    var peripheralNames: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.peripheralsDidChange?()
            }
        }
    }
    
    var peripheralsDidChange: (() -> Void)?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}


extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "Unknow device")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(peripheral.name)
        print(peripheral.description)
    }
}
