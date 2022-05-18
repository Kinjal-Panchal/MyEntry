//
//  MessageBar.swift
//  Oppera
//
//  Created by EWW077 on 24/04/1941 Saka.
//  Copyright © 1941 eww090. All rights reserved.
//

import UIKit
import SwiftMessages

class MessageBarController: NSObject {
    
    
    func MessageShow(title : NSString , alertType : MessageView.Layout , alertTheme : Theme , TopBottom : Bool) -> Void {
        //Hide All popup when present any one popup
         SwiftMessages.hideAll()

        //Top Bottom
        //1 = Top , 2 = Bottom
        
        let alert = MessageView.viewFromNib(layout: alertType)
        alert.titleLabel?.font = CustomFont.Bold.returnFont(13.0)
        alert.titleLabel?.numberOfLines = 0
        alert.bodyLabel?.font =  CustomFont.Bold.returnFont(12.0)
        alert.bodyLabel?.numberOfLines = 2
        
        //Alert Type
        alert.configureTheme(alertTheme)
        alert.configureDropShadow()
        alert.button?.isHidden = true
        
        //Set title value
        //       alertTheme.hashValue
        alert.configureContent(title: alertTheme == .success ? "Success" : "Error", body: title as String)
        
        var successConfig = SwiftMessages.defaultConfig
        
        //Type for present popup is bottom or top
        (TopBottom == true) ? (successConfig.presentationStyle = .top):(successConfig.presentationStyle = .bottom)
        //successConfig.duration = .seconds(seconds: 0.25)
        
        //Configaration with Start with status bar
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar.rawValue)
        
        
        SwiftMessages.show(config: successConfig, view: alert)
    }
    
    
    
    func SocketMessageShow(title : NSString , alertType : MessageView.Layout , alertTheme : Theme , TopBottom : Bool) -> Void {
        SwiftMessages.hideAll()
        SocketMessageShowCustom(title: title, alertTheme: alertTheme, TopBottom: TopBottom)
    }


    func SocketMessageShowCustom(title : NSString , alertTheme : Theme , TopBottom : Bool) -> Void {
        //Hide All popup when present any one popup
        // SwiftMessages.hideAll()

        //Top Bottom
        //1 = Top , 2 = Bottom
        let alert: CustomCardView = try! SwiftMessages.viewFromNib()

//        let alert = MessageView.viewFromNib(layout: alertType)
//        alert.titleLabel?.font = FontBook.ProximaNovaSemiBold.of(size: 13)
//        alert.titleLabel?.numberOfLines = 0
        alert.lblBodyLabel?.text = title as String
        alert.lblBodyLabel?.font = CustomFont.Regular.returnFont(13.0)
        alert.lblBodyLabel?.numberOfLines = 2
        alert.lblBodyLabel.textColor = UIColor.black



        //Alert Type
//        alert.configureTheme(alertTheme)
        alert.configureDropShadow()
        alert.button?.isHidden = true

        alert.indicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 40), type: .ballBeat, color: colors.ThemePink.value, padding: -20)
        alert.indicatorView.type = .ballBeat
        alert.indicatorView.color = colors.ThemePink.value
        alert.indicatorView.startAnimating()

        alert.indicatorViewContainer.addSubview(alert.indicatorView)
        alert.indicatorViewContainer.layoutIfNeeded()
//        alert.indicatorView.frame = alert.indicatorViewContainer.bounds
//        alert.indicatorView.backgroundColor = UIColor.gray
        //Set title value
        //       alertTheme.hashValue
//        alert.configureContent(title: alertTheme == .info ? "Locked" : "Success" , body: title as String)

        var successConfig = SwiftMessages.defaultConfig
        successConfig.duration = .forever
        //Type for present popup is bottom or top
        (TopBottom == true) ? (successConfig.presentationStyle = .top):(successConfig.presentationStyle = .top)
        //successConfig.duration = .seconds(seconds: 0.25)

        //Configaration with Start with status bar
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar.rawValue)


        SwiftMessages.show(config: successConfig, view: alert)

    }
    
    
    
    
    
    
    
}

