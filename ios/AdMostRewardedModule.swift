import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostRewardedModule)
class AdMostRewardedModule: NSObject, AMRRewardedVideoDelegate {

    var rewardedVideo: AMRRewardedVideo!
    var zoneId: String!

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func loadAd(
        _ zoneId: NSString,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {

        if self.rewardedVideo == nil || self.zoneId != zoneId as String {
            self.rewardedVideo = AMRRewardedVideo(forZoneId: zoneId as String)
            self.rewardedVideo.delegate = self
            self.zoneId = zoneId as String
        }

        self.rewardedVideo.load()
    }

    @objc
    func showAd(
        _ resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        rewardedVideo.show(from: UIApplication.shared.delegate?.window??.rootViewController)
    }

    func didReceive(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_READY", body: [])
    }

    func didFail(toReceive rewardedVideo: AMRRewardedVideo!, error: AMRError!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_FAIL", body: ["errorCode": error.errorCode, "errorDescription": error.errorDescription!])
    }

    func didShow(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_SHOWN", body: [])
    }

    func didClick(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_CLICKED", body: [])
    }

    func didComplete(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_COMPLETE", body: [])
    }

    func didDismiss(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_DISMISS", body: [])
    }

    func didRewardedVideoStateChanged(_ rewardedVideo: AMRRewardedVideo!, state: AMRAdState) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_STATUS_CHANGED", body: ["statusCode": state])
    }

}
