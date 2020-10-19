package com.admost.reactnative;

import android.annotation.SuppressLint;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.facebook.react.bridge.ReactContext;

import admost.sdk.AdMostView;
import admost.sdk.listener.AdMostViewListener;

@SuppressLint("ViewConstructor")
public class AdMostAdView extends FrameLayout {
  public static final String TAG = AdMostAdView.class.getSimpleName();

  private final ReactContext context;
  private View rootView;
  private ViewGroup adViewGroup;
  private AdMostViewListener adViewListener;
  private String zoneId;
  private AdMostView adMostView;

  public AdMostAdView(ReactContext context) {
    super(context);
    this.context = context;
    this.rootView = inflate(getContext(), R.layout.layout_banner, this);
    this.adViewGroup = rootView.findViewById(R.id.ad_container);
    this.adViewListener = createAdListener();
  }

  public static AdMostAdView newView(ReactContext reactContext) {
    return new AdMostAdView(reactContext);
  }

  public void loadAd() {
    if (adMostView == null) {
      this.adMostView = new AdMostView(context.getCurrentActivity(), this.zoneId, 0, this.adViewListener, null);
    }
    adMostView.load();
  }

  private AdMostViewListener createAdListener() {
    return new AdMostViewListener() {
      @Override
      public void onReady(String network, int ecpm, View adView) {
        Log.d(TAG, "AdMostView on ready, network: " + network);

        adViewGroup.removeAllViews();
        adViewGroup.addView(adView);
        refreshViewChildrenLayout(adViewGroup);
      }

      @Override
      public void onFail(int errorCode) {
        Log.d(TAG, "AdMostView on fail, errorCode: " + errorCode);
      }

      @Override
      public void onClick(String network) {
        Log.d(TAG, "AdMostView on click, network: " + network);
      }
    };
  }

  //bugs: https://github.com/facebook/react-native/issues/17968
  private void refreshViewChildrenLayout(View view) {
    view.measure(
        View.MeasureSpec.makeMeasureSpec(view.getMeasuredWidth(), View.MeasureSpec.EXACTLY),
        View.MeasureSpec.makeMeasureSpec(view.getMeasuredHeight(), View.MeasureSpec.EXACTLY)
    );
    view.layout(view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
  }

  public void setZoneId(String zoneId) {
    this.zoneId = zoneId;
  }
}
