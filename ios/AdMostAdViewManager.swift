@objc(AdMostAdViewManager)
class AdMostAdViewManager: RCTViewManager {

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    override func view() -> UIView! {
        return AdMostAdView()
    }

    @objc func loadAd(_ node: NSNumber) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! AdMostAdView
            component.loadAd()
        }
    }

    @objc func destroyAd(_ node: NSNumber) {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! AdMostAdView
            component.destroyAd()
        }
    }
}

