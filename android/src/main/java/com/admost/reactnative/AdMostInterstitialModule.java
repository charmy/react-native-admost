package com.admost.reactnative;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;

import admost.sdk.AdMostInterstitial;
import admost.sdk.listener.AdMostAdListener;

public class AdMostInterstitialModule extends ReactContextBaseJavaModule implements AdMostAdListener {

  private static final String TAG = AdMostInterstitialModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;
  private AdMostInterstitial adMostInterstitial;
  private String zoneId = "";

  public AdMostInterstitialModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @NonNull
  @Override
  public String getName() {
    return "AdMostInterstitial";
  }

  @ReactMethod
  public void loadAd(String zoneId) {
    if (this.adMostInterstitial == null || !this.zoneId.equals(zoneId)) {
      if (this.adMostInterstitial != null) {
        this.adMostInterstitial.destroy();
      }

      this.adMostInterstitial = new AdMostInterstitial(getCurrentActivity(), zoneId, this);
      this.adMostInterstitial.refreshAd(false);
      this.zoneId = zoneId;
    }

    this.adMostInterstitial.refreshAd(false);
  }

  @ReactMethod
  public void showAd() {
    this.adMostInterstitial.show();
  }

  @ReactMethod
  public void isLoading(final Promise promise) {
    promise.resolve(this.adMostInterstitial.isLoading());
  }

  @ReactMethod
  public void isLoaded(final Promise promise) {
    promise.resolve(this.adMostInterstitial.isLoaded());
  }

  @Override
  public void onReady(String network, int ecpm) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putInt("ecpm", ecpm);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_READY", params);
  }

  @Override
  public void onFail(int errorCode) {
    WritableMap params = Arguments.createMap();
    params.putInt("errorCode", errorCode);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_FAIL", params);
  }

  @Override
  public void onDismiss(String message) {
    WritableMap params = Arguments.createMap();
    params.putString("message", message);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_DISMISS", params);
  }

  @Override
  public void onComplete(String network) {
  }

  @Override
  public void onShown(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_SHOWN", params);
  }

  @Override
  public void onClicked(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_CLICKED", params);
  }

  @Override
  public void onStatusChanged(int statusCode) {
    WritableMap params = Arguments.createMap();
    params.putInt("statusCode", statusCode);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_INTERSTITIAL_ON_STATUS_CHANGED", params);
  }
}
