package com.admost.reactnative;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;

public class AdMostRewardedModule extends ReactContextBaseJavaModule {

  private static final String TAG = AdMostRewardedModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;

  public AdMostRewardedModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "AdMostRewarded";
  }
}
