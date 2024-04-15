import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostModule)
class AdMostModule: RCTEventEmitter {

    public static var instance: AdMostModule!

    @objc
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    override init() {
        super.init()
        AdMostModule.instance = self
    }

    @objc
    func initAdMost(
        _ config: NSDictionary,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {

        let configurations = config as! Dictionary<String, Any>

        if config["appId"] == nil {
            reject("ADMOST_MISSING_PARAM", "appId is required", nil);
            return
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

        if #available(iOS 14.5, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                AMRSDK.updateATTStatus()
                // Tracking authorization completed.
            })
        }

        AMRSDK.start(withAppId: configurations["appId"] as! String)
        resolve(true)
    }

    @objc
    func setUserId(_ userId: NSString) -> Void {
        AMRSDK.setUserId(userId as String)
    }

    @objc
    func setCanRequestAds(_ canRequestsAds: Bool) -> Void {
        AMRSDK.canRequestAds(canRequestsAds)
    }
    
    @objc
    func trackIAP(_ data: NSDictionary) -> Void {
        let dataDict = data as! Dictionary<String, Any>
        
        let transactionId = dataDict["transactionId"] as! String
        let currency = dataDict["currency"] as! String
        let price = dataDict["price"] as! Double
        
        var tags: [String] = []
        if dataDict["tag"] != nil {
            let tag = dataDict["tag"] as! String
            tags = [tag]
        }
        
        AMRSDK.trackIAP(transactionId, currencyCode: currency, amount: price, tags: tags)
    }

    public func sendEvent(eventName: String, body: Any?) -> Void {
        sendEvent(withName: eventName, body: body)
    }

    override func supportedEvents() -> [String]! {
        return [
            "ADMOST_INTERSTITIAL_ON_READY",
            "ADMOST_INTERSTITIAL_ON_FAIL",
            "ADMOST_INTERSTITIAL_ON_DISMISS",
            "ADMOST_INTERSTITIAL_ON_SHOWN",
            "ADMOST_INTERSTITIAL_ON_CLICKED",
            "ADMOST_INTERSTITIAL_ON_STATUS_CHANGED",
            "ADMOST_REWARDED_ON_READY",
            "ADMOST_REWARDED_ON_FAIL",
            "ADMOST_REWARDED_ON_DISMISS",
            "ADMOST_REWARDED_ON_COMPLETE",
            "ADMOST_REWARDED_ON_SHOWN",
            "ADMOST_REWARDED_ON_CLICKED",
            "ADMOST_REWARDED_ON_STATUS_CHANGED",
        ]
    }

}
