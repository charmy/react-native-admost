import UIKit
import AMRSDK

class AdMostAdView: UIView, AMRBannerDelegate {

    var mpuBanner: AMRBanner!
    var adZoneId: NSString!
    var adTag: NSString!
    var adLayoutName: NSString!
    
    @objc var onReady: RCTDirectEventBlock?
    @objc var onFail: RCTDirectEventBlock?
    @objc var onClick: RCTDirectEventBlock?

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
        
        mpuBanner.load(withTag: adTag as String?)
    }

    func destroyAd() {

    }

    func didReceive(_ banner: AMRBanner!) {
        self.addSubview(banner.bannerView)
        
        if onReady != nil {
            onReady!(["zoneId": adZoneId!, "ecpm": banner.ecpm!, "network": banner.networkName!])
        }
    }

    func didFail(toReceive banner: AMRBanner!, error: AMRError!) {
        if onFail != nil {
            onFail!(["zoneId": adZoneId!, "errorCode": error.errorCode, "errorDescription": error.errorDescription!])
        }
    }

    func didClick(_ banner: AMRBanner!) {
        if onClick != nil {
            onClick!(["zoneId": adZoneId!, "network": banner.networkName!])
        }
    }

    @objc var zoneId: NSString = "" {
        didSet {
            adZoneId = zoneId;
        }
    }
    
    @objc var nsTag: NSString = "" {
        didSet {
            adTag = nsTag;
        }
    }

    @objc var layoutName: NSString = "DEFAULT" {
        didSet {
            adLayoutName = layoutName;
        }
    }
}
