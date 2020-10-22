import AMRSDK
import AppTrackingTransparency
import AdSupport

@objc(AdMostInterstitialModule)
class AdMostInterstitialModule: NSObject, AMRInterstitialDelegate {

    var interstitial: AMRInterstitial!
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

        if self.interstitial == nil || self.zoneId != zoneId as String {
            self.interstitial = AMRInterstitial(forZoneId: zoneId as String)
            self.interstitial.delegate = self
            self.zoneId = zoneId as String
        }

        self.interstitial.load()
    }

    @objc
    func showAd(
        _ resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        interstitial.show(from: UIApplication.shared.delegate?.window??.rootViewController)
    }

    func didReceive(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_READY", body: [])
    }

    func didFail(toReceive interstitial: AMRInterstitial!, error: AMRError!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_FAIL", body: ["errorCode": error.errorCode, "errorDescription": error.errorDescription!])
    }

    func didShow(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_SHOWN", body: [])
    }

    func didClick(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_CLICKED", body: [])
    }

    func didDismiss(_ interstitial: AMRInterstitial!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_DISMISS", body: [])
    }

    func didInterstitialStateChanged(_ interstitial: AMRInterstitial!, state: AMRAdState) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_INTERSTITIAL_ON_STATUS_CHANGED", body: ["statusCode": state])
    }

}
