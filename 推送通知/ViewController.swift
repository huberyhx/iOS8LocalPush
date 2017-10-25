//
//  ViewController.swift
//  推送通知
//
//  Created by hubery on 2017/10/20.
//  Copyright © 2017年 hubery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    ///Users/ouhiroshiasahi/Desktop/iOS本地推送通知/iOS本地推送通知/ViewController.swift:18:20: Argument labels '(forTypes:, categories:)' do not match any available overloads
    @IBAction func send(_ sender: UIButton) {
        //创建一个通知
        let localNot = UILocalNotification()
        //设置通知的必选项
        localNot.alertBody = "我是通知"
        //通知的发送时间
        localNot.fireDate = NSDate(timeIntervalSinceNow: 2) as Date
        
        //重复发送时间周期
//        localNot.repeatInterval = NSCalendar.Unit.minute
        //设置锁屏滑动文字
        localNot.alertAction = "回复"
        if #available(iOS 8.2, *) {
            localNot.alertTitle = "哈喽"
        }
        // 设置通知的声音
        localNot.soundName = "win.aac"
        localNot.category = "select"
        // 设置图标右上角的数字(0 代表不显示)
        localNot.applicationIconBadgeNumber = 10
        //立即发送
        //UIApplication.shared.presentLocalNotificationNow(localNot)
        //按照规定时间发送
        UIApplication.shared.scheduleLocalNotification(localNot)
    }
    
    //取消取消没发送的通知
    @IBAction func cancel(_ sender: UIButton) {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    //查看通知
    @IBAction func lookUp(_ sender: UIButton) {
        print(UIApplication.shared.scheduledLocalNotifications!)
    }
    
}

