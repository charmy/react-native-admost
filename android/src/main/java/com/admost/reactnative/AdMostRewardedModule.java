package com.admost.reactnative;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;

import java.util.HashMap;

import admost.sdk.AdMostInterstitial;
import admost.sdk.listener.AdMostAdListener;

public class AdMostRewardedModule extends ReactContextBaseJavaModule {

  private static final String TAG = AdMostRewardedModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;
  private final HashMap<String, AdMostInterstitial> adMostRewardedMap; // zoneId -> AdMostRewarded

  public AdMostRewardedModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.adMostRewardedMap = new HashMap<>();
  }

  @NonNull
  @Override
  public String getName() {
    return "AdMostRewarded";
  }

  @ReactMethod
  public void loadAd(final String zoneId) {
    AdMostInterstitial adMostRewarded = adMostRewardedMap.get(zoneId);

    if (adMostRewarded == null) {
      AdMostInterstitial newAdMostRewarded = new AdMostInterstitial(getCurrentActivity(), zoneId, getListener(zoneId));
      adMostRewardedMap.put(zoneId, newAdMostRewarded);
      newAdMostRewarded.refreshAd(false);
      return;
    }

    adMostRewarded.refreshAd(false);
  }

  @ReactMethod
  public void destroyAd(final String zoneId) {
    AdMostInterstitial adMostRewarded = adMostRewardedMap.get(zoneId);

    if (adMostRewarded != null) {
      adMostRewarded.destroy();
      adMostRewardedMap.remove(zoneId);
    }
  }

  @ReactMethod
  public void showAd(final String zoneId, final Promise promise) {
    AdMostInterstitial adMostRewarded = adMostRewardedMap.get(zoneId);

    if (adMostRewarded != null) {
      adMostRewarded.show();
      promise.resolve(true);
    } else {
      promise.reject(Constants.ADMOST_INSTANCE_NOT_FOUND, "Couldn't find any instance in this zone, call loadAd");
    }
  }

  @ReactMethod
  public void isLoading(final String zoneId, final Promise promise) {
    AdMostInterstitial adMostRewarded = adMostRewardedMap.get(zoneId);

    if (adMostRewarded != null) {
      promise.resolve(adMostRewarded.isLoading());
    } else {
      promise.reject(Constants.ADMOST_INSTANCE_NOT_FOUND, "Couldn't find any instance in this zone, call loadAd");
    }
  }

  @ReactMethod
  public void isLoaded(final String zoneId, final Promise promise) {
    AdMostInterstitial adMostRewarded = adMostRewardedMap.get(zoneId);

    if (adMostRewarded != null) {
      promise.resolve(adMostRewarded.isLoaded());
    } else {
      promise.reject(Constants.ADMOST_INSTANCE_NOT_FOUND, "Couldn't find any instance in this zone, call loadAd");
    }
  }

  private AdMostAdListener getListener(final String zoneId) {
    return new AdMostAdListener() {
      @Override
      public void onReady(String network, int ecpm) {
        WritableMap params = Arguments.createMap();
        params.putString("network", network);
        params.putInt("ecpm", ecpm);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_READY, params);
      }

      @Override
      public void onFail(int errorCode) {
        WritableMap params = Arguments.createMap();
        params.putInt("errorCode", errorCode);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_FAIL, params);
      }

      @Override
      public void onDismiss(String message) {
        WritableMap params = Arguments.createMap();
        params.putString("message", message);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_DISMISS, params);
      }

      @Override
      public void onComplete(String network) {
        WritableMap params = Arguments.createMap();
        params.putString("network", network);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_COMPLETE, params);
      }

      @Override
      public void onShown(String network) {
        WritableMap params = Arguments.createMap();
        params.putString("network", network);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_SHOWN, params);
      }

      @Override
      public void onClicked(String network) {
        WritableMap params = Arguments.createMap();
        params.putString("network", network);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_CLICKED, params);
      }

      @Override
      public void onStatusChanged(int statusCode) {
        WritableMap params = Arguments.createMap();
        params.putInt("statusCode", statusCode);
        params.putString("zoneId", zoneId);

        AdMostModule.sendEvent(Constants.ADMOST_REWARDED_ON_STATUS_CHANGED, params);
      }
    };
  }

}
