package com.admost.reactnative;

import android.annotation.SuppressLint;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;

import admost.sdk.AdMostView;
import admost.sdk.AdMostViewBinder;
import admost.sdk.listener.AdMostViewListener;

@SuppressLint("ViewConstructor")
public class AdMostAdView extends FrameLayout implements AdMostViewListener {

  public static final String TAG = AdMostAdView.class.getSimpleName();
  private final ReactContext context;
  private View rootView;
  private ViewGroup adViewGroup;
  private String zoneId;
  private String layoutName = "DEFAULT";
  private AdMostView adMostView;

  public AdMostAdView(ReactContext context) {
    super(context);
    this.context = context;
    this.rootView = inflate(getContext(), R.layout.layout_banner, this);
    this.adViewGroup = rootView.findViewById(R.id.ad_container);
  }

  public static AdMostAdView newView(ReactContext reactContext) {
    return new AdMostAdView(reactContext);
  }

  public void loadAd() {
    if (adMostView == null) {
      this.adMostView = new AdMostView(context.getCurrentActivity(), this.zoneId, 0, this, getAdMostViewBinder());
    }
    adMostView.load();
  }

  public void destroyAd() {
    if (adMostView != null) {
      adMostView.destroy();
    }
  }

  @Override
  public void onReady(String network, int ecpm, View adView) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_BANNER_ON_READY", params);

    adViewGroup.removeAllViews();
    adViewGroup.addView(adView);
    refreshViewChildrenLayout(adViewGroup);
  }

  @Override
  public void onFail(int errorCode) {
    WritableMap params = Arguments.createMap();
    params.putInt("errorCode", errorCode);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_BANNER_ON_FAIL", params);
  }

  @Override
  public void onClick(String network) {
    WritableMap params = Arguments.createMap();
    params.putString("network", network);
    params.putString("zoneId", zoneId);

    AdMostModule.sendEvent("ADMOST_BANNER_ON_CLICK", params);
  }

  //bugs: https://github.com/facebook/react-native/issues/17968
  private void refreshViewChildrenLayout(View view) {
    view.measure(
        View.MeasureSpec.makeMeasureSpec(view.getMeasuredWidth(), View.MeasureSpec.EXACTLY),
        View.MeasureSpec.makeMeasureSpec(view.getMeasuredHeight(), View.MeasureSpec.EXACTLY)
    );
    view.layout(view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
  }

  private AdMostViewBinder getAdMostViewBinder() {
    if (layoutName.equals("DEFAULT")) {
      return null;
    }

    int layoutId = getLayoutIdWithName(layoutName);
    if (layoutId == 0) {
      return null;
    }

    return new AdMostViewBinder.Builder(layoutId)
        .iconImageId(R.id.ad_app_icon)
        .titleId(R.id.ad_headline)
        .callToActionId(R.id.ad_call_to_action)
        .textId(R.id.ad_body)
        .attributionId(R.id.ad_attribution)
        .mainImageId(R.id.ad_image)
        .backImageId(R.id.ad_back)
        .privacyIconId(R.id.ad_privacy_icon)
        .isRoundedMode(true)
        .build();
  }

  private int getLayoutIdWithName(String layoutName) {
    return getResources().getIdentifier(layoutName, "layout", context.getPackageName());
  }

  public void setZoneId(String zoneId) {
    this.zoneId = zoneId;
  }

  public void setLayoutName(String layoutName) {
    this.layoutName = layoutName;
  }
}
