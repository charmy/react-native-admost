import { NativeModules, NativeEventEmitter } from "react-native";
export AdMostAdView from "./AdMostAdView";

export const { AdMost, AdMostInterstitial, AdMostRewarded } = NativeModules;
export const AdMostEventEmitter = new NativeEventEmitter(AdMost);

export const BannerAdEvents = {
    ON_READY: "ADMOST_BANNER_ON_READY",
    ON_FAIL: "ADMOST_BANNER_ON_FAIL",
    ON_CLICK: "ADMOST_BANNER_ON_CLICK",
};

export const InterstitialAdEvents = {
    ON_READY: "ADMOST_INTERSTITIAL_ON_READY",
    ON_FAIL: "ADMOST_INTERSTITIAL_ON_FAIL",
    ON_DISMISS: "ADMOST_INTERSTITIAL_ON_DISMISS",
    ON_SHOWN: "ADMOST_INTERSTITIAL_ON_SHOWN",
    ON_CLICKED: "ADMOST_INTERSTITIAL_ON_CLICKED",
    ON_STATUS_CHANGED: "ADMOST_INTERSTITIAL_ON_STATUS_CHANGED",
};

export const RewardedAdEvents = {
    ON_READY: "ADMOST_REWARDED_ON_READY",
    ON_FAIL: "ADMOST_REWARDED_ON_FAIL",
    ON_DISMISS: "ADMOST_REWARDED_ON_DISMISS",
    ON_COMPLETE: "ADMOST_REWARDED_ON_COMPLETE",
    ON_SHOWN: "ADMOST_REWARDED_ON_SHOWN",
    ON_CLICKED: "ADMOST_REWARDED_ON_CLICKED",
    ON_STATUS_CHANGED: "ADMOST_REWARDED_ON_STATUS_CHANGED",
};

if (__DEV__) {
    AdMostEventEmitter.addListener(BannerAdEvents.ON_READY, (e) => {
        console.debug("AdMostBannerAdEventEmitter.ON_READY", e);
    });
    AdMostEventEmitter.addListener(BannerAdEvents.ON_FAIL, (e) => {
        console.debug("AdMostBannerAdEventEmitter.ON_FAIL", e);
    });
    AdMostEventEmitter.addListener(BannerAdEvents.ON_CLICK, (e) => {
        console.debug("AdMostBannerAdEventEmitter.ON_CLICK", e);
    });
}

export default AdMost;
