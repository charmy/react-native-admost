import UIKit
import AMRSDK

class AdMostAdView: UIView, AMRBannerDelegate {

    var mpuBanner: AMRBanner!
    var adZoneId: NSString!
    var adLayoutName: NSString!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadAd() {
        if mpuBanner == nil {
            mpuBanner = AMRBanner.init(forZoneId: adZoneId as String)
            mpuBanner.delegate = self
            mpuBanner.bannerWidth = self.bounds.size.width

            if adLayoutName != "DEFAULT" {
                mpuBanner.customNativeSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height)
                mpuBanner.customeNativeXibName = adLayoutName as String?
            }
        }
        mpuBanner.load()
    }

    func destroyAd() {

    }

    func didReceive(_ banner: AMRBanner!) {
        self.addSubview(banner.bannerView)
        AdMostModule.instance.sendEvent(eventName: "ADMOST_BANNER_ON_READY", body: ["zoneId": adZoneId])
    }

    func didFail(toReceive banner: AMRBanner!, error: AMRError!) {
        AdMostModule.instance.sendEvent(
            eventName: "ADMOST_BANNER_ON_FAIL",
            body: ["zoneId": adZoneId!, "errorCode": error.errorCode, "errorDescription": error.errorDescription!]
        )
    }

    func didClick(_ banner: AMRBanner!) {
        AdMostModule.instance.sendEvent(eventName: "ADMOST_BANNER_ON_CLICK", body: ["zoneId": adZoneId])
    }

    @objc var zoneId: NSString = "" {
        didSet {
            adZoneId = zoneId;
        }
    }

    @objc var layoutName: NSString = "DEFAULT" {
        didSet {
            adLayoutName = layoutName;
        }
    }
}
