package com.admost.reactnative;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

import javax.annotation.Nonnull;

public class AdMostAdViewManager extends SimpleViewManager<AdMostAdView> {
  private static final String REACT_CLASS = "RCTAdMostAdView";

  @NonNull
  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @NonNull
  @Override
  protected AdMostAdView createViewInstance(@NonNull ThemedReactContext reactContext) {
    return AdMostAdView.newView(reactContext);
  }

  @Override
  public void receiveCommand(@Nonnull AdMostAdView view, String commandId,
                             @Nullable ReadableArray args) {
    switch (commandId) {
      case "loadAd":
        view.loadAd();
        break;
      case "destroyAd":
        view.destroyAd();
        break;
    }
  }

  @ReactProp(name = "zoneId")
  public void setZoneId(AdMostAdView view, String zoneId) {
    view.setZoneId(zoneId);
  }

  @ReactProp(name = "layoutName")
  public void setLayoutName(AdMostAdView view, String layoutName) {
    view.setLayoutName(layoutName);
  }
}
