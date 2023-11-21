import React, { useEffect } from "react";
import { View, StatusBar, Button, SafeAreaView } from "react-native";

import AdMost, { AdMostAdView, AdMostInterstitial, AdMostRewarded } from "react-native-admost";

export default function App() {
  useEffect(() => {
    const appId = "02331a7c-4ec0-4d90-b07f-ca8a015a94ae";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
      userId: undefined,
    });
  }, []);

  // Interstitial events
  useEffect(() => {
    const adMostOnReadyEvent = AdMost.addInterstitialListener.onReady((e) => {
      console.log("ON_READY", e);
      AdMostInterstitial.showAd(e.zoneId, "TEST");
    });

    const adMostOnFailEvent = AdMost.addInterstitialListener.onFail((e) => {
      console.log("ON_FAIL", e);
    });

    const adMostOnShownEvent = AdMost.addInterstitialListener.onDismiss((e) => {
      console.log("ON_DISMISS", e);
    });

    const adMostOnClickedEvent = AdMost.addInterstitialListener.onShown((e) => {
      console.log("ON_SHOWN", e);
    });

    const adMostOnDismissEvent = AdMost.addInterstitialListener.onClicked((e) => {
      console.log("ON_CLICKED", e);
    });

    const adMostOnStatusChangedEvent = AdMost.addInterstitialListener.onStatusChanged((e) => {
      console.log("ON_STATUS_CHANGED", e);
    });

    return () => {
      adMostOnReadyEvent.remove();
      adMostOnFailEvent.remove();
      adMostOnShownEvent.remove();
      adMostOnClickedEvent.remove();
      adMostOnDismissEvent.remove();
      adMostOnStatusChangedEvent.remove();
    };
  });

  // Rewarded events
  useEffect(() => {
    const adMostOnReadyEvent = AdMost.addRewardedListener.onReady((e) => {
      console.log("ON_READY", e);
      AdMostRewarded.showAd(e.zoneId, "TEST");
    });

    const adMostOnFailEvent = AdMost.addRewardedListener.onFail((e) => {
      console.log("ON_FAIL", e);
    });

    const adMostOnShownEvent = AdMost.addRewardedListener.onDismiss((e) => {
      console.log("ON_DISMISS", e);
    });

    const adMostOnCompleteEvent = AdMost.addRewardedListener.onComplete((e) => {
      console.log("ON_COMPLETE", e);
    });

    const adMostOnClickedEvent = AdMost.addRewardedListener.onShown((e) => {
      console.log("ON_SHOWN", e);
    });

    const adMostOnDismissEvent = AdMost.addRewardedListener.onClicked((e) => {
      console.log("ON_CLICKED", e);
    });

    const adMostOnStatusChangedEvent = AdMost.addRewardedListener.onStatusChanged((e) => {
      console.log("ON_STATUS_CHANGED", e);
    });

    return () => {
      adMostOnReadyEvent.remove();
      adMostOnFailEvent.remove();
      adMostOnCompleteEvent.remove();
      adMostOnShownEvent.remove();
      adMostOnClickedEvent.remove();
      adMostOnDismissEvent.remove();
      adMostOnStatusChangedEvent.remove();
    };
  });

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={{ flex: 1, justifyContent: "center" }}>
        <StatusBar barStyle="dark-content" backgroundColor="#ffffff" />
        <AdMostAdView
          zoneId="c4a15983-d6fe-49ec-8e8b-844663190559"
          tag="Ragib"
          style={{ width: "100%", height: 50 }}
          onReady={({ nativeEvent }) => {
            console.log("ON_READY", nativeEvent);
          }}
          onFail={({ nativeEvent }) => {
            console.log("ON_FAIL", nativeEvent);
          }}
          onClick={({ nativeEvent }) => {
            console.log("ON_CLICK", nativeEvent);
          }}
        />

        <AdMostAdView
          zoneId="3e0d8189-ec55-4530-bf8b-970712d48649"
          style={{ width: "100%", height: 250 }}
          onReady={({ nativeEvent }) => {
            console.log("ON_READY", nativeEvent);
          }}
          onFail={({ nativeEvent }) => {
            console.log("ON_FAIL", nativeEvent);
          }}
          onClick={({ nativeEvent }) => {
            console.log("ON_CLICK", nativeEvent);
          }}
        />

        <Button
          onPress={() => AdMostInterstitial.loadAd("a5583948-19bb-4cd5-b558-da5ff1bdbfcc")}
          title="Load Interstitial Ad"
          color="red"
        />
        <Button
          onPress={() => AdMostRewarded.loadAd("f8e8a661-44b9-4691-8e4b-7323f03c5291")}
          title="Load Rewarded Ad"
          color="red"
        />
      </View>
    </SafeAreaView>
  );
}
