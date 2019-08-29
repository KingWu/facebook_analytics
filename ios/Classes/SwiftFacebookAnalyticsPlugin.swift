import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftFacebookAnalyticsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "facebook_analytics", binaryMessenger: registrar.messenger())
        let instance = SwiftFacebookAnalyticsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "logEvent"){
            guard let args = call.arguments else {
                return
            }
            if let myArgs = args as? [String: Any],
                let eventName = myArgs["name"] as? String,
                let parameters = myArgs["parameters"] as? [String: Any]
            {
                FBSDKAppEvents.logEvent(eventName, parameters: parameters)
            } else if
                let myArgs = args as? [String: Any],
                let eventName = myArgs["name"] as? String
            {
                FBSDKAppEvents.logEvent(eventName)
            }
        }
        else if(call.method == "setUserID"){
            guard let args = call.arguments else {
                return
            }
            
            if let myArgs = args as? [String: Any],
                let userId = myArgs["userId"] as? String
            {
                 FBSDKAppEvents.setUserID(userId)
            }
        }
        else if(call.method == "updateUserProperties"){
            guard let args = call.arguments else {
                return
            }
            
            if let myArgs = args as? [String: Any],
                let parameters = myArgs["parameters"] as? [String: Any]
            {
                FBSDKAppEvents.updateUserProperties(parameters, handler: nil)
            }
        }
    }
}
