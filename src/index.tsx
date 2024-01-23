import { type EmitterSubscription, NativeEventEmitter, NativeModules } from "react-native";
import AdMostAdView from "./AdMostAdView";

interface InterstitialEvent {
  onReady: (cb: (e: { network: string; ecpm: number; zoneId: string }) => void) => EmitterSubscription;
  onFail: (cb: (e: { errorCode: number; errorDescription?: string; zoneId: string }) => void) => EmitterSubscription;
  onDismiss: (cb: (e: { message?: string; zoneId: string }) => void) => EmitterSubscription;
  onShown: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
  onClicked: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
  onStatusChanged: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
}

interface RewardedEvent {
  onReady: (cb: (e: { network: string; ecpm: number; zoneId: string }) => void) => EmitterSubscription;
  onFail: (cb: (e: { errorCode: number; errorDescription?: string; zoneId: string }) => void) => EmitterSubscription;
  onDismiss: (cb: (e: { message?: string; zoneId: string }) => void) => EmitterSubscription;
  onComplete: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
  onShown: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
  onClicked: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
  onStatusChanged: (cb: (e: { network: string; zoneId: string }) => void) => EmitterSubscription;
}

interface AdMostProps {
  initAdMost: (config: {
    appId: string;
    userConsent?: boolean;
    subjectToGDPR?: boolean;
    subjectToCCPA?: boolean;
    userChild?: boolean;
  }) => Promise<void>;

  setUserId: (userId: string) => void;
  setCanRequestAds: (canRequestsAds: boolean) => void;

  addInterstitialListener: InterstitialEvent;
  addRewardedListener: RewardedEvent;
}

interface InterstitialProps {
  loadAd: (zoneId: string) => void;
  destroyAd: (zoneId: string) => void;
  showAd: (zoneId: string, tag: string) => Promise<void>;
  isLoading: (zoneId: string) => Promise<boolean>;
  isLoaded: (zoneId: string) => Promise<boolean>;
}

interface RewardedProps {
  loadAd: (zoneId: string) => void;
  destroyAd: (zoneId: string) => void;
  showAd: (zoneId: string, tag: string) => Promise<void>;
  isLoading: (zoneId: string) => Promise<boolean>;
  isLoaded: (zoneId: string) => Promise<boolean>;
}

const AdMostEventEmitter = new NativeEventEmitter(NativeModules.AdMost);

export const AdMostInterstitial = NativeModules.AdMostInterstitial as InterstitialProps;
export const AdMostRewarded = NativeModules.AdMostRewarded as RewardedProps;
export { AdMostAdView };

export default {
  initAdMost: NativeModules.AdMost.initAdMost,
  setUserId: NativeModules.AdMost.setUserId,
  setCanRequestAds: NativeModules.AdMost.setCanRequestAds,

  addInterstitialListener: {
    onReady: (cb: (e: { network: string; ecpm: number; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_READY`, cb);
    },
    onFail: (cb: (e: { errorCode: number; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_FAIL`, cb);
    },
    onDismiss: (cb: (e: { message: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_DISMISS`, cb);
    },
    onShown: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_SHOWN`, cb);
    },
    onClicked: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_CLICKED`, cb);
    },
    onStatusChanged: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_INTERSTITIAL_ON_STATUS_CHANGED`, cb);
    },
  },

  addRewardedListener: {
    onReady: (cb: (e: { network: string; ecpm: number; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_READY`, cb);
    },
    onFail: (cb: (e: { errorCode: number; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_FAIL`, cb);
    },
    onDismiss: (cb: (e: { message: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_DISMISS`, cb);
    },
    onComplete: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_COMPLETE`, cb);
    },
    onShown: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_SHOWN`, cb);
    },
    onClicked: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_CLICKED`, cb);
    },
    onStatusChanged: (cb: (e: { network: string; zoneId: string }) => void) => {
      return AdMostEventEmitter.addListener(`ADMOST_REWARDED_ON_STATUS_CHANGED`, cb);
    },
  },
} as AdMostProps;
