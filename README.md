# react-native-admost

## Getting started

```shell script
$ npm install @charmy.tech/react-native-admost --save
```

### Android
- You should follow the "Edit Files" section on [AdMost](https://admost.github.io/amrandroid/#edit-files)
- These dependencies already exist in gradle
```
  implementation 'com.admost.sdk:amr:+' 
  implementation 'com.google.android.gms:play-services-base:17.1.0' 
```

#### Update Project `build.grandle`
```
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://mvn-repo.admost.com/artifactory/amr-2' }
    }
}
```


### IOS
- You should follow the "Create your podfile and install" section on [AdMost](https://admost.github.io/amrios/#create-your-podfile-and-install)
- These dependencies already exist in pod
```
  s.dependency "AMRSDK", "~> 1.5"
```

## Usage

### AdMostAdView

```typescript jsx
import React, { useEffect } from "react";
import { View, StatusBar, SafeAreaView } from "react-native";

import AdMost, { AdMostAdView } from "@charmy.tech/react-native-admost";

export default function App() {
  useEffect(() => {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
    });

    AdMost.setUserId("123123");
    AdMost.setCanRequestAds(false);
  }, []);

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
          zoneId="<admost-zone-id>"
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
      </View>
    </SafeAreaView>
  );
}

```

#### Android Custom Layout
- Create android layout from android studio
- [It should be like this](./assets/android-custom-layout.png)
- Set layoutName prop to view

#### IOS Custom Layout
- `cp -r CustomXibs ${project_rootdir}/node_modules/@charmy.tech/react-native-admost/`
- `pod install in ios folder`
- [It should be like this](./assets/ios-custom-layout.png)
- Set layoutName prop to view

#### Props
| Prop            | Required | Type      | Default value | Description                                                                                        |
|-----------------|----------|-----------|---------------|----------------------------------------------------------------------------------------------------|
| zoneId          | true     | string    |               | AdMost zoneId                                                                                      |
| layoutName      | false    | string    | DEFAULT       | Custom layout name(layout_admost_native_250, CustomNative200x200)                                  |                                                             |
| tag             | false    | string    |               | Tags will let you monitor the performance of the ads across different dimensions for the same zone |                                                             |
| style           | true     | ViewStyle |               | View style ({ width: "100%", height: 50 })                                                         | 
| autoLoadDelayMs | false    | number    | 100           | Auto load delay (min 100 ms)                                                                       | 
| onReady         | false    | func      |               | on ready callback event                                                                            | 
| onFail          | false    | func      |               | on fail callback event                                                                             | 
| onClick         | false    | func      |               | on click callback event                                                                            |

### AdMostInterstitial
```typescript jsx
import React, { useEffect } from "react";
import { View, StatusBar, Button, SafeAreaView } from "react-native";

import AdMost, { AdMostInterstitial } from "@charmy.tech/react-native-admost";

export default function App() {
  useEffect(() => {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
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

    const adMostOnDismissEvent = AdMost.addInterstitialListener.onDismiss((e) => {
      console.log("ON_DISMISS", e);
    });

    const adMostOnShownEvent = AdMost.addInterstitialListener.onShown((e) => {
      console.log("ON_SHOWN", e);
    });

    const adMostOnClickedEvent = AdMost.addInterstitialListener.onClicked((e) => {
      console.log("ON_CLICKED", e);
    });

    const adMostOnStatusChangedEvent = AdMost.addInterstitialListener.onStatusChanged((e) => {
      console.log("ON_STATUS_CHANGED", e);
    });

    return () => {
      adMostOnReadyEvent.remove();
      adMostOnFailEvent.remove();
      adMostOnDismissEvent.remove();
      adMostOnShownEvent.remove();
      adMostOnClickedEvent.remove();
      adMostOnStatusChangedEvent.remove();
    };
  });

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={{ flex: 1, justifyContent: "center" }}>
        <StatusBar barStyle="dark-content" backgroundColor="#ffffff" />
        <Button
          onPress={() => AdMostInterstitial.loadAd("<admost-zone-id>")}
          title="Load Interstitial Ad"
          color="red"
        />
      </View>
    </SafeAreaView>
  );
}
```


#### Methods
| Name             | Params                         | Return           | Description           |
|------------------|--------------------------------|------------------|-----------------------|
| loadAd           | (zoneId: string)               | void             | Load ad               |
| destroyAd        | (zoneId: string)               | void             | Destroy Ad            |
| showAd           | (zoneId: string, tag: string)  | Promise<boolean> | Show when ad is ready |
| isLoading        | (zoneId: string)               | Promise<boolean> | Ad is loading         |
| isLoaded         | (zoneId: string)               | Promise<boolean> | Ad is loaded          |

#### Events
| Name                 | Params                                                                |
|----------------------|-----------------------------------------------------------------------|
| ON_READY             | { network: string; ecpm: number; zoneId: string }                     |
| ON_FAIL              | { errorCode: number; errorDescription?: string(iOS); zoneId: string } |
| ON_DISMISS           | { message?: string(Android); zoneId: string }                         |
| ON_SHOWN             | { network: string; zoneId: string }                                   |
| ON_CLICKED           | { network: string; zoneId: string }                                   |
| ON_STATUS_CHANGED    | { network: string; zoneId: string }                                   |

### AdMostRewarded
```typescript jsx
import React, { useEffect } from "react";
import { View, StatusBar, Button, SafeAreaView } from "react-native";

import AdMost, { AdMostRewarded } from "@charmy.tech/react-native-admost";

export default function App() {
  useEffect(() => {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
    });
  }, []);

  // Rewarded events
  useEffect(() => {
    const adMostOnReadyEvent = AdMost.addRewardedListener.onReady((e) => {
      console.log("ON_READY", e);
      AdMostRewarded.showAd(e.zoneId, "TEST");
    });

    const adMostOnFailEvent = AdMost.addRewardedListener.onFail((e) => {
      console.log("ON_FAIL", e);
    });

    const adMostOnDismissEvent = AdMost.addRewardedListener.onDismiss((e) => {
      console.log("ON_DISMISS", e);
    });

    const adMostOnCompleteEvent = AdMost.addRewardedListener.onComplete((e) => {
      console.log("ON_COMPLETE", e);
    });

    const adMostOnShownEvent = AdMost.addRewardedListener.onShown((e) => {
      console.log("ON_SHOWN", e);
    });

    const adMostOnClickedEvent = AdMost.addRewardedListener.onClicked((e) => {
      console.log("ON_CLICKED", e);
    });

    const adMostOnStatusChangedEvent = AdMost.addRewardedListener.onStatusChanged((e) => {
      console.log("ON_STATUS_CHANGED", e);
    });

    return () => {
      adMostOnReadyEvent.remove();
      adMostOnFailEvent.remove();
      adMostOnDismissEvent.remove();
      adMostOnCompleteEvent.remove();
      adMostOnShownEvent.remove();
      adMostOnClickedEvent.remove();
      adMostOnStatusChangedEvent.remove();
    };
  });

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={{ flex: 1, justifyContent: "center" }}>
        <StatusBar barStyle="dark-content" backgroundColor="#ffffff" />
        <Button
          onPress={() => AdMostRewarded.loadAd("<admost-zone-id>")}
          title="Load Rewarded Ad"
          color="red"
        />
      </View>
    </SafeAreaView>
  );
}
```

#### Methods
| Name             | Params                         | Return           | Description           |
|------------------|--------------------------------|------------------|-----------------------|
| loadAd           | (zoneId: string)               | void             | Load ad               |
| destroyAd        | (zoneId: string)               | void             | Destroy Ad            |
| showAd           | (zoneId: string, tag: string)  | Promise<boolean> | Show when ad is ready |
| isLoading        | (zoneId: string)               | Promise<boolean> | Ad is loading         |
| isLoaded         | (zoneId: string)               | Promise<boolean> | Ad is loaded          |

#### Events
| Name                 | Params                                                                |
|----------------------|-----------------------------------------------------------------------|
| ON_READY             | { network: string; ecpm: number; zoneId: string }                     |
| ON_FAIL              | { errorCode: number; errorDescription?: string(iOS); zoneId: string } |
| ON_DISMISS           | { message?: string(Android); zoneId: string }                         |
| ON_COMPLETE          | { network: string; zoneId: string }                                   |
| ON_SHOWN             | { network: string; zoneId: string }                                   |
| ON_CLICKED           | { network: string; zoneId: string }                                   |
| ON_STATUS_CHANGED    | { network: string; zoneId: string }                                   |
