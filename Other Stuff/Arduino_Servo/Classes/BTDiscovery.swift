//
//  BTDiscovery.swift
//  Arduino_Servo
//
//  Created by Owen L Brown on 9/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

let btDiscoverySharedInstance = BTDiscovery();

class BTDiscovery: NSObject, CBCentralManagerDelegate {
  
  fileprivate var centralManager: CBCentralManager? // The phone
  fileprivate var peripheralBLE: CBPeripheral?      // The Arduino bluetooth module
  
  override init() {
    super.init()
    
    let centralQueue = DispatchQueue(label: "io.skaplan", attributes: [])
    centralManager = CBCentralManager(delegate: self, queue: centralQueue)
  }
  
  func startScanning() {
    if let central = centralManager {
        // Scan for a BLE device with a matching service UUID
        central.scanForPeripherals(withServices: [BLEServiceUUID], options: nil)
    }
  }
  
  var bleService: BTService? {
    didSet {
      if let service = self.bleService {
        service.startDiscoveringServices()
      }
    }
  }
  
  // MARK: - CBCentralManagerDelegate
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    // Be sure to retain the peripheral or it will fail during connection.
    // Called once peripheral with matching service UUID is discovered
    
    // Validate peripheral information
    if ((peripheral.name == nil) || (peripheral.name! != "FF01")) {
        // Don't connect to any device that uses the same service but has a different name
        return
    } else {
        print("Found: "+peripheral.name!)
    }
    
    // If not already connected to a peripheral, then connect to this one
    if ((self.peripheralBLE == nil) || (self.peripheralBLE?.state == CBPeripheralState.disconnected)) {
      // Retain the peripheral before trying to connect
      self.peripheralBLE = peripheral
      
      // Reset service
      self.bleService = nil
      
      // Connect to peripheral
      central.connect(peripheral, options: nil)
    }
  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    // Called after connecting to FF01 BLE device
    
    // Create new service class
    if (peripheral == self.peripheralBLE) {
      self.bleService = BTService(initWithPeripheral: peripheral)
    }
    
    // Stop scanning for new devices
    central.stopScan()
  }
  
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    
    // See if it was our peripheral that disconnected
    if (peripheral == self.peripheralBLE) {
      self.bleService = nil;
      self.peripheralBLE = nil;
    }
    
    // Start scanning for new devices
    self.startScanning()
  }
  
  // MARK: - Private
  
  func clearDevices() {
    self.bleService = nil
    self.peripheralBLE = nil
  }
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch (central.state) {
    case .poweredOff:
      self.clearDevices()
      
    case .unauthorized:
      // Indicate to user that the iOS device does not support BLE.
      break
      
    case .unknown:
      // Wait for another event
      break
      
    case .poweredOn:
      self.startScanning()
      
    case .resetting:
      self.clearDevices()
      
    case .unsupported:
      break
    }
  }

}
