import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostModule)
class AdMostModule: NSObject {

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func initAdMost(
            _ config: NSDictionary,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {

        let configurations = config as! Dictionary<String, Any>

        if config["appId"] == nil {
            fatalError("Missing required param 'appId'")
        }

        if configurations["userConsent"] != nil {
            AMRSDK.setUserConsent(configurations["userConsent"] as! Bool)
        }

        if configurations["subjectToGDPR"] != nil {
            AMRSDK.subject(toGDPR: configurations["subjectToGDPR"] as! Bool)
        }

        if configurations["subjectToCCPA"] != nil {
            AMRSDK.subject(toCCPA: configurations["subjectToCCPA"] as! Bool)
        }

        if configurations["userChild"] != nil {
            AMRSDK.setUserChild(configurations["userChild"] as! Bool)
        }

        if configurations["userId"] != nil {
            AMRSDK.setUserId(configurations["userId"] as! String)
        }


        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                // Tracking authorization completed.
            })
        }

        AMRSDK.start(withAppId: configurations["appId"] as! String)
    }
}
