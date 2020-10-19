package com.admost.reactnative;

import android.app.Activity;
import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

import admost.sdk.base.AdMost;
import admost.sdk.base.AdMostConfiguration;
import admost.sdk.listener.AdMostInitListener;

public class AdMostModule extends ReactContextBaseJavaModule {

  private static final String TAG = AdMostModule.class.getSimpleName();
  private final ReactApplicationContext reactContext;

  public AdMostModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "AdMost";
  }

  @ReactMethod
  public void initAdMost(ReadableMap readableMap) {
    AdMostConfiguration adMostConfiguration = getAdmostConfiguration(readableMap);

    AdMost.getInstance().init(adMostConfiguration, new AdMostInitListener() {
      @Override
      public void onInitCompleted() {
        Log.i(TAG, "init completed");
      }

      @Override
      public void onInitFailed(int err) {
        Log.i(TAG, "init failed, errorCode: " + err);
      }
    });
  }

  private AdMostConfiguration getAdmostConfiguration(ReadableMap readableMap) {
    Activity currentActivity = getCurrentActivity();

    if (!readableMap.hasKey("appId")) {
      throw new AdMostException("Missing required param 'appId'");
    }

    String appId = readableMap.getString("appId");
    AdMostConfiguration.Builder adMostConfigBuilder = new AdMostConfiguration.Builder(currentActivity, appId);

    if (readableMap.hasKey("userConsent")) {
      adMostConfigBuilder.setUserConsent(readableMap.getBoolean("userConsent"));
    }

    if (readableMap.hasKey("subjectToGDPR")) {
      adMostConfigBuilder.setSubjectToGDPR(readableMap.getBoolean("subjectToGDPR"));
    }

    if (readableMap.hasKey("subjectToCCPA")) {
      adMostConfigBuilder.setSubjectToCCPA(readableMap.getBoolean("subjectToCCPA"));
    }

    if (readableMap.hasKey("userChild")) {
      adMostConfigBuilder.setUserChild(readableMap.getBoolean("userChild"));
    }

    return adMostConfigBuilder.build();
  }
}
