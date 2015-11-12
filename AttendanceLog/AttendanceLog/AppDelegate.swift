//
//  AppDelegate.swift
//  AttendanceLog
//
//  Created by Mike Henry on 11/12/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var beaconsManager = BeaconsManager.sharedInstance


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        beaconsManager.beaconManager.delegate = beaconsManager.self
        beaconsManager.checkForLocationAuthorization()
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("qmvSzdTwYHIsLVtZpWlRLVEbz9NOV0Urq82dv335",
            clientKey: "2iecP0N681yMGxmTf6UxeZpmlrRpETVP7fJGZbaa")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        return true
    }


}

