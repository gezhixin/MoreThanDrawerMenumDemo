//
//  AppDelegate.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/16.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootLRMViewController : LeftRightMenuRootViewController!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let leftVC = LeftMenuViewController(nibName:"LeftMenuViewController", bundle:nil);
        let homeVC = HomePageViewController(nibName:"HomePageViewController", bundle:nil);
        let homeNVC = UINavigationController(rootViewController: homeVC)
        let leftNVC = UINavigationController(rootViewController: leftVC)
        
        let importentVC = MySpecialDayViewController(nibName:"MySpecialDayViewController", bundle:nil)
        let importentNVC = UINavigationController(rootViewController: importentVC)
        importentNVC.view.x = CenterViewOffset
        
        let favouriteVC = FavouriteViewController(nibName:"FavouriteViewController", bundle:nil)
        let favouriteNCV = UINavigationController(rootViewController: favouriteVC)
        favouriteNCV.view.x = CenterViewOffset
        
        leftVC.homePageViewContoller = homeNVC
        leftVC.favouriteViewController = favouriteNCV
        leftVC.importentDayViewController = importentNVC
        
        //设置分界线样式(layer边缘阴影）
        self.setViewBoundary(homeNVC)
        self.setViewBoundary(favouriteNCV)
        self.setViewBoundary(importentNVC)
        
        let rootVC = LeftRightMenuRootViewController()
        rootVC.leftNavigationController = leftNVC
        rootVC.centerNavigationController = homeNVC
        rootLRMViewController = rootVC
        
        self.window!.rootViewController = rootVC
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func setViewBoundary(nvc: UINavigationController)
    {
    
        nvc.view.layer.shadowOffset = CGSizeMake(0,0);
        nvc.view.layer.shadowOpacity = 0.5;
        nvc.view.layer.shadowRadius = 7.0;
        nvc.view.layer.shadowColor = UIColor.blackColor().CGColor
        
        let shadowPath = UIBezierPath(rect:nvc.view.bounds)
        nvc.view.layer.shadowPath = shadowPath.CGPath;
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

