package com.admost.reactnative;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;

public class AdMostInterstitialModule extends ReactContextBaseJavaModule {

  private static final String TAG = AdMostInterstitialModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;

  public AdMostInterstitialModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "AdMostInterstitial";
  }
}
