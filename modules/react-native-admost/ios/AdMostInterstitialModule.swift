import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostInterstitialModule)
class AdMostInterstitialModule: NSObject, AMRInterstitialDelegate {

    var adMostInterstitialDict: Dictionary<String, AMRInterstitial> = [:] // zoneId -> AMRInterstitial

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func loadAd(_ zoneId: NSString) -> Void {
        let adMostInterstitial = adMostInterstitialDict[zoneId as String]

        if adMostInterstitial == nil {
            let newAdMostInterstitial: AMRInterstitial = AMRInterstitial(forZoneId: zoneId as String)
            newAdMostInterstitial.delegate = self
            adMostInterstitialDict[zoneId as String] = newAdMostInterstitial

            newAdMostInterstitial.load()
            return;
        }

        adMostInterstitial?.load()
    }

    @objc
    func destroyAd(_ zoneId: NSString) -> Void {
        let adMostInterstitial = adMostInterstitialDict[zoneId as String]

        if adMostInterstitial != nil {
            // todo: destroy adMostAd
            adMostInterstitialDict.removeValue(forKey: zoneId as String)
        }
    }

    @objc
    func showAd(
            _ zoneId: NSString,
            tag adTag: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostInterstitial = adMostInterstitialDict[zoneId as String]

        if adMostInterstitial != nil {
            adMostInterstitial?.show(from: UIApplication.shared.delegate?.window??.rootViewController, withTag: adTag as String)
            resolve(true)
        } else {
            reject("ADMOST_INSTANCE_NOT_FOUND", "Couldn't find any instance in this zone, call loadAd", nil);
        }
    }

    @objc
    func isLoading(
            _ zoneId: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostInterstitial = adMostInterstitialDict[zoneId as String]

        if adMostInterstitial != nil {
            resolve(adMostInterstitial?.isLoading)
        } else {
            reject("ADMOST_INSTANCE_NOT_FOUND", "Couldn't find any instance in this zone, call loadAd", nil);
        }
    }

    @objc
    func isLoaded(
            _ zoneId: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostInterstitial = adMostInterstitialDict[zoneId as String]

        if adMostInterstitial != nil {
            resolve(adMostInterstitial?.isLoaded)
        } else {
            reject("ADMOST_INSTANCE_NOT_FOUND", "Couldn't find any instance in this zone, call loadAd", nil);
        }
    }

    func didReceive(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_READY",
                body: ["network": interstitial.networkName!, "ecpm": interstitial.ecpm!, "zoneId": interstitial.zoneId!]
        )
    }

    func didFail(toReceive interstitial: AMRInterstitial!, error: AMRError!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_FAIL",
                body: ["errorDescription": error.errorDescription!, "errorCode": error.errorCode, "zoneId": interstitial.zoneId!]
        )
    }
    
    func didDismiss(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_DISMISS",
                body: ["zoneId": interstitial.zoneId!]
        )
    }

    func didShow(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_SHOWN",
                body: ["network": interstitial.networkName!, "zoneId": interstitial.zoneId!]
        )
    }

    func didClick(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_CLICKED",
                body: ["network": interstitial.networkName!, "zoneId": interstitial.zoneId!]
        )
    }

    func didInterstitialStateChanged(_ interstitial: AMRInterstitial!, state: AMRAdState) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_INTERSTITIAL_ON_STATUS_CHANGED",
                body: ["zoneId": interstitial.zoneId!, "statusCode": state]
        )
    }
}
