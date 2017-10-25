//
//  AppDelegate.swift
//  推送通知
//
//  Created by hubery on 2017/10/20.
//  Copyright © 2017年 hubery. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var a : CGFloat = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //创建一组操作行为
        let category : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        //设置行为标识
        category.identifier = "select"
        //添加操作行为
        let action1 = UIMutableUserNotificationAction()
        action1.identifier = "buli"
        action1.title = "不理"
        //在前台执行
        action1.activationMode = UIUserNotificationActivationMode.foreground
        //是否需要解锁
        action1.isAuthenticationRequired = true
        //是否为破坏性行为
        action1.isDestructive = true
        
        let action2 = UIMutableUserNotificationAction()
        action2.identifier = "huifu"
        action2.title = "回复"
        //显示输入框
        if #available(iOS 9.0, *) {
            action2.behavior = UIUserNotificationActionBehavior.textInput
            action2.parameters = [UIUserNotificationTextInputActionButtonTitleKey : "走你"]
        }
        action1.activationMode = UIUserNotificationActivationMode.background
        action1.isAuthenticationRequired = false
        action1.isDestructive = false
        
        let actions = [action1, action2]
        //default:默认两个action
        category.setActions(actions, for: UIUserNotificationActionContext.default)
        let categories : Set<UIUserNotificationCategory> = [category]
        //在iOS8以后 需要申请通知权限
        //rawValue是取其原始值(比如0 1 2)
        //.alert .badge是实际值
        let type = UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue
        let sets = UIUserNotificationSettings(types: UIUserNotificationType(rawValue : type), categories: categories)
        UIApplication.shared.registerUserNotificationSettings(sets)
        
        
        //launchOptions: 只要不是正常启动(点击图标启动)
        //当APP启动以后 这个key对应的值不为空,那么就是点击了通知进入APP
        if launchOptions != nil {
            let local = launchOptions![UIApplicationLaunchOptionsKey.localNotification]
            if local != nil {
                print(local!)
            }
        }
        return true
    }
    
    //点击通知
    //接受到通知并且满足以下条件时就会调用:
    //在前台
    //在后台或者锁屏点击了通知的时候
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        let state = UIApplication.shared.applicationState
        if state == UIApplicationState.active {//如果在前台
            a = a + 1
            print("在前台 \(a)");
        }else if state == UIApplicationState.inactive{//如果在后台
            a = a + 1
            print("在后台 \(a)");
        }
    }
    
    //操作的监听
    //iOS8.0
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print(identifier!)
        completionHandler()
    }
    //iOS9.0
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print(identifier!, responseInfo)
        completionHandler()
    }

}

