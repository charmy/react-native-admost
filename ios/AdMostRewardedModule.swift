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

    @objc
    func isLoading(
        _ resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        resolve(rewardedVideo.isLoading)
    }

    @objc
    func isLoaded(
        _ resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        resolve(rewardedVideo.isLoaded)
    }

    func didReceive(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_READY", body: ["zoneId": zoneId])
    }

    func didFail(toReceive rewardedVideo: AMRRewardedVideo!, error: AMRError!) {
        AdMostModule.instance.sendEvent(
            eventName: "ADMOST_REWARDED_ON_FAIL",
            body: ["zoneId": zoneId!, "errorCode": error.errorCode, "errorDescription": error.errorDescription!]
        )
    }

    func didShow(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_SHOWN", body: ["zoneId": zoneId])
    }

    func didClick(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_CLICKED", body: ["zoneId": zoneId])
    }

    func didComplete(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_COMPLETE", body: ["zoneId": zoneId])
    }

    func didDismiss(_ rewardedVideo: AMRRewardedVideo!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_DISMISS", body: ["zoneId": zoneId])
    }

    func didRewardedVideoStateChanged(_ rewardedVideo: AMRRewardedVideo!, state: AMRAdState) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_REWARDED_ON_STATUS_CHANGED", body: ["zoneId": zoneId!, "statusCode": state])
    }

}
