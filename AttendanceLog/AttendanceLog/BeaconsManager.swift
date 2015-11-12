//
//  BeaconsManager.swift
//  AttendanceLog
//
//  Created by Mike Henry on 11/12/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconsManager: UIViewController, ESTBeaconManagerDelegate {
    
    static let sharedInstance = BeaconsManager()
    let beaconManager = ESTBeaconManager()
    var lastRegion: CLBeaconRegion?
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let nearestBeacon = beacons[0]
            if region != lastRegion {
                switch nearestBeacon.proximity {
                case .Immediate:
                    print("Ranged Immedate \(region.identifier) beacon")
                case .Near:
                    print("Ranged Near \(region.identifier) beacon")
                case .Far:
                    print("Ranged Far \(region.identifier) beacon")
                case .Unknown:
                    print("Ranged Uknown \(region.identifier) beacon")
                }
                lastRegion = region
            }
        }
    }
    
    func beaconManager(manager: AnyObject, didDetermineState state: CLRegionState, forRegion region: CLBeaconRegion) {
        switch state {
        case .Unknown:
            print("Region \(region.identifier) Uknown")
        case .Inside:
            print("Inside \(region.identifier) Region")
        case .Outside:
            print("Outside \(region.identifier) Region")
        }
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        print("Did Enter Region: \(region.identifier)")
    }
    
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        print("Did Exit Region: \(region.identifier)")
    }
    
    func setUpBeacons() {
        print("Setting Up Beacons")
        let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        let beaconUUID = NSUUID(UUIDString: uuidString)!
        
        let beaconIdentifier = "IronYard"
        let allBeaconsRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier)
        beaconManager.startMonitoringForRegion(allBeaconsRegion)
        
        let beacon1major :CLBeaconMajorValue = 39380
        let beacon1minor :CLBeaconMinorValue = 44024
        let beacon1identifier = "PurpleBeacon"
        let purpleBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon1major, minor: beacon1minor, identifier: beacon1identifier)
        beaconManager.startRangingBeaconsInRegion(purpleBeaconRegion)
        
        let beacon2major :CLBeaconMajorValue = 31640
        let beacon2minor :CLBeaconMinorValue = 65404
        let beacon2identifier = "BlueBeacon"
        let blueBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon2major, minor: beacon2minor, identifier: beacon2identifier)
        beaconManager.startRangingBeaconsInRegion(blueBeaconRegion)
        
        let beacon3major :CLBeaconMajorValue = 34909
        let beacon3minor :CLBeaconMinorValue = 15660
        let beacon3identifier = "MintBeacon"
        let mintBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon3major, minor: beacon3minor, identifier: beacon3identifier)
        beaconManager.startRangingBeaconsInRegion(mintBeaconRegion)
    }
    
    func checkForLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            print("Location Services on")
            switch ESTBeaconManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Start Up")
                setUpBeacons()
            case .Denied, .Restricted:
                print("Turn on Location Services in Settings")
            case .NotDetermined:
                print("Not determined")
                if beaconManager.respondsToSelector("requestAlwaysAuthorization") {
                    print("Requesting Always")
                    beaconManager.requestAlwaysAuthorization()
                }
            }
        } else {
            print("Turn on Location Services")
        }
    }
    
}
