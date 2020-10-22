package com.admost.reactnative;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;

import admost.sdk.AdMostInterstitial;
import admost.sdk.listener.AdMostAdListener;

public class AdMostRewardedModule extends ReactContextBaseJavaModule implements AdMostAdListener {

  private static final String TAG = AdMostRewardedModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;
  private AdMostInterstitial adMostRewarded;
  private String zoneId = "";

  public AdMostRewardedModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @NonNull
  @Override
  public String getName() {
    return "AdMostRewarded";
  }

  @ReactMethod
  public void loadAd(String zoneId) {
    if (this.adMostRewarded == null || !this.zoneId.equals(zoneId)) {
      if (this.adMostRewarded != null) {
        this.adMostRewarded.destroy();
      }

      this.adMostRewarded = new AdMostInterstitial(getCurrentActivity(), zoneId, this);
      this.adMostRewarded.refreshAd(false);
      this.zoneId = zoneId;
    }

    this.adMostRewarded.refreshAd(false);
  }

  @ReactMethod
  public void showAd() {
    this.adMostRewarded.show();
  }

  @Override
  public void onReady(String network, int ecpm) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putInt("ecpm", ecpm);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_READY", params);
  }

  @Override
  public void onFail(int errorCode) {
    WritableMap params = Arguments.createMap();
    params.putInt("errorCode", errorCode);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_FAIL", params);
  }

  @Override
  public void onDismiss(String message) {
    WritableMap params = Arguments.createMap();
    params.putString("message", message);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_DISMISS", params);
  }

  @Override
  public void onComplete(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_COMPLETE", params);
  }

  @Override
  public void onShown(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_SHOWN", params);
  }

  @Override
  public void onClicked(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_CLICKED", params);
  }

  @Override
  public void onStatusChanged(int statusCode) {
    WritableMap params = Arguments.createMap();
    params.putInt("statusCode", statusCode);

    AdMostModule.sendEvent("ADMOST_REWARDED_ON_STATUS_CHANGED", params);
  }
}
