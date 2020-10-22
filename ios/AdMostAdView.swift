import UIKit
import AMRSDK

class AdMostAdView: UIView, AMRBannerDelegate {

    var mpuBanner: AMRBanner!
    var adZoneId: NSString = ""

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

            //todo: custom ad
            //bannerCustom200x200.customNativeSize = CGSize(width: 200.0, height: 200.0)
            //bannerCustom200x200.customeNativeXibName = "CustomNative200x200"
        }
        mpuBanner.load()
    }

    func didReceive(_ banner: AMRBanner!) {
        self.addSubview(banner.bannerView)
    }

    func didFail(toReceive banner: AMRBanner!, error: AMRError!) {
        print("AdMostAdView didFail, " + error.errorDescription)
    }

    func didClick(_ banner: AMRBanner!) {
    }

    @objc var zoneId: NSString = "" {
        didSet {
            adZoneId = zoneId;
        }
    }
}
