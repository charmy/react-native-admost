package com.admost.reactnative;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import admost.sdk.base.AdMost;
import admost.sdk.base.AdMostConfiguration;
import admost.sdk.listener.AdMostInitListener;

public class AdMostModule extends ReactContextBaseJavaModule {

  private static final String TAG = AdMostModule.class.getSimpleName();
  private static ReactApplicationContext reactContext;

  public AdMostModule(ReactApplicationContext reactContext) {
    super(reactContext);
    AdMostModule.reactContext = reactContext;
  }

  public static void sendEvent(String eventName, @Nullable WritableMap params) {
    reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
        .emit(eventName, params);
  }

  @NonNull
  @Override
  public String getName() {
    return "AdMost";
  }

  @ReactMethod
  public void initAdMost(final ReadableMap readableMap, final Promise promise) {
    AdMostConfiguration adMostConfiguration = getAdmostConfiguration(readableMap);

    AdMost.getInstance().init(adMostConfiguration, new AdMostInitListener() {
      @Override
      public void onInitCompleted() {
        promise.resolve("init completed");
      }

      @Override
      public void onInitFailed(int err) {
        promise.reject(String.valueOf(err), "init failed, errorCode: " + err);
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

    if (readableMap.hasKey("userId")) {
      AdMost.getInstance().setUserId(readableMap.getString("userId"));
    }

    return adMostConfigBuilder.build();
  }
}
