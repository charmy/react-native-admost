package com.admost.reactnative;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

import java.util.Map;

import javax.annotation.Nonnull;

public class AdMostAdViewManager extends SimpleViewManager<AdMostAdView> {
  private static final String REACT_CLASS = "RCTAdMostAdView";
  private static final int LOAD_AD = 0;

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

  @Nullable
  @Override
  public Map<String, Integer> getCommandsMap() {
    return MapBuilder.of(
        "loadAd", LOAD_AD
    );
  }

  @Override
  public void receiveCommand(@Nonnull AdMostAdView view, int commandId,
                             @Nullable ReadableArray args) {
    if (commandId == LOAD_AD) {
      view.loadAd();
    }
  }

  @ReactProp(name = "zoneId")
  public void setZoneId(AdMostAdView view, String zoneId) {
    view.setZoneId(zoneId);
  }
}
