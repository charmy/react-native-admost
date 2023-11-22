import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostRewardedModule)
class AdMostRewardedModule: NSObject, AMRRewardedVideoDelegate {

    var adMostRewardedDict: Dictionary<String, AMRRewardedVideo> = [:] // zoneId -> AdMostRewarded

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func loadAd(
            _ zoneId: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostRewarded = adMostRewardedDict[zoneId as String]

        if adMostRewarded == nil {
            let newAdMostRewarded: AMRRewardedVideo = AMRRewardedVideo(forZoneId: zoneId as String)
            newAdMostRewarded.delegate = self
            adMostRewardedDict[zoneId as String] = newAdMostRewarded

            newAdMostRewarded.load()
            return;
        }

        adMostRewarded?.load()
    }

    @objc
    func destroyAd(
            _ zoneId: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostRewarded = adMostRewardedDict[zoneId as String]

        if adMostRewarded != nil {
            // todo: destroy adMostAd
            adMostRewardedDict.removeValue(forKey: zoneId as String)
        }
    }

    @objc
    func showAd(
            _ zoneId: NSString,
            tag adTag: NSString,
            resolver resolve: RCTPromiseResolveBlock,
            rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        let adMostRewarded = adMostRewardedDict[zoneId as String]

        if adMostRewarded != nil {
            adMostRewarded?.show(from: UIApplication.shared.delegate?.window??.rootViewController, withTag: adTag as String)
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
        let adMostRewarded = adMostRewardedDict[zoneId as String]

        if adMostRewarded != nil {
            resolve(adMostRewarded?.isLoading)
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
        let adMostRewarded = adMostRewardedDict[zoneId as String]

        if adMostRewarded != nil {
            resolve(adMostRewarded?.isLoaded)
        } else {
            reject("ADMOST_INSTANCE_NOT_FOUND", "Couldn't find any instance in this zone, call loadAd", nil);
        }
    }

    func didReceive(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_READY",
                body: ["network": rewardedVideo.networkName!, "ecpm": rewardedVideo.ecpm!, "zoneId": rewardedVideo.zoneId!]
        )
    }

    func didFail(toReceive rewardedVideo: AMRRewardedVideo!, error: AMRError!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_FAIL",
                body: ["errorDescription": error.errorDescription!, "errorCode": error.errorCode, "zoneId": rewardedVideo.zoneId!]
        )
    }
    
    func didDismiss(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_DISMISS",
                body: ["zoneId": rewardedVideo.zoneId!]
        )
    }
    
    func didComplete(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_COMPLETE",
                body: ["network": rewardedVideo.networkName!, "zoneId": rewardedVideo.zoneId!]
        )
    }

    func didShow(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_SHOWN",
                body: ["network": rewardedVideo.networkName!, "zoneId": rewardedVideo.zoneId!]
        )
    }

    func didClick(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_CLICKED",
                body: ["network": rewardedVideo.networkName!, "zoneId": rewardedVideo.zoneId!]
        )
    }

    func didRewardedVideoStateChanged(_ rewardedVideo: AMRRewardedVideo!, state: AMRAdState) {
        AdMostModule.instance.sendEvent(
                eventName: "ADMOST_REWARDED_ON_STATUS_CHANGED",
                body: ["zoneId": rewardedVideo.zoneId!, "statusCode": state]
        )
    }

}
