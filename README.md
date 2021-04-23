# react-native-admost

## Getting started

```shell script
$ npm install @up-inside/react-native-admost --save
```

### Android
- You should follow the "Edit Files" section on [AdMost](https://admost.github.io/amrandroid/#edit-files)
- These dependencies already exist in gradle
```
  implementation 'com.android.volley:volley:1.1.1'
  implementation 'com.admost.sdk:amr:2.2.9'
  implementation 'com.google.android.gms:play-services-base:17.1.0'
```

### IOS
- You should follow the "Create your podfile and install" section on [AdMost](https://admost.github.io/amrios/#create-your-podfile-and-install)
- These dependencies already exist in pod
```
  s.dependency "AMRSDK", "~> 1.4"
```

## Usage

### AdMostAdView

```javascript
import React from "react";
import { Button, View } from "react-native";
import AdMost, { AdMostAdView, BannerAdEvents, AdMostEventEmitter } from "@up-inside/react-native-admost";

export default class App extends React.Component {
  componentDidMount() {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
      userId: undefined,
    });

    this.setListeners();
    // this.admostAdViewRef.loadAd();
  }

  componentWillUnmount() {
    this.clearListeners();
  }

  setListeners() {
    this.adMostOnReadyEvent = AdMostEventEmitter.addListener(BannerAdEvents.ON_READY, (e) => {
      console.log("ON_READY", e);
    });

    this.adMostOnFailEvent = AdMostEventEmitter.addListener(BannerAdEvents.ON_FAIL, (e) => {
      console.log("ON_FAIL", e);
    });

    this.adMostOnClickEvent = AdMostEventEmitter.addListener(BannerAdEvents.ON_CLICK, (e) => {
      console.log("ON_CLICK", e);
    });
  }

  clearListeners() {
    this.adMostOnReadyEvent.remove();
    this.adMostOnFailEvent.remove();
    this.adMostOnClickEvent.remove();
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <AdMostAdView
          ref={(ref) => (this.admostAdViewRef = ref)}
          style={{ width: "100%", height: 250 }}
          zoneId={adMostZoneId}
        />
      </View>
    );
  }
}
```

#### Android Custom Layout
- Create android layout from android studio
- [It will look like this](./assets/android-custom-layout.png)
- Set layoutName prop to view

#### IOS Custom Layout
- `cp -r CustomXibs ${project_rootdir}/node_modules/@up-inside/react-native-admost/`
- `pod install in ios folder`
- [It will look like this](./assets/ios-custom-layout.png)
- Set layoutName prop to view

#### Props
| Prop                 | Required | Type     | Default value | Description                                                              |
|----------------------|----------|----------|---------------|--------------------------------------------------------------------------|
| zoneId               | true     | string   |               | AdMost zoneId                                                            |
| layoutName           | false    | string   | DEFAULT       | Custom layout name(layout_admost_native_250, CustomNative200x200)        |                                                             |
| autoLoadDelayMs      | false    | number   | 100           | Auto load delay (min 100 ms)                                             | 
| autoLoad             | false    | bool     | true          | Load ad when AdmostAdView is mount                                       | 

#### Methods
| Name             | Params             | Return  | Description                                 |
|------------------|--------------------|---------|----------------------------------------------|
| loadAd           |                    | void    | Load ad manually                             |

### AdMostInterstitial
```javascript
import React from "react";
import { Button, View } from "react-native";
import AdMost, { AdMostEventEmitter, AdMostInterstitial, InterstitialAdEvents } from "@up-inside/react-native-admost";

export default class SplashScreen extends React.Component {
  componentDidMount() {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
      userId: undefined,
    });

    this.setListeners();
  }

  componentWillUnmount() {
    this.clearListeners();
  }

  setListeners() {
    this.adMostOnReadyEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_READY, (e) => {
      console.log("ON_READY", e);
      AdMostInterstitial.showAd();
    });

    this.adMostOnFailEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_FAIL, (e) => {
      console.log("ON_FAIL", e);
    });

    this.adMostOnShownEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_SHOWN, (e) => {
      console.log("ON_SHOWN", e);
    });

    this.adMostOnClickedEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_CLICKED, (e) => {
      console.log("ON_CLICKED", e);
    });

    this.adMostOnDismissEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_DISMISS, (e) => {
      console.log("ON_DISMISS", e);
    });

    this.adMostOnStatusChangedEvent = AdMostEventEmitter.addListener(InterstitialAdEvents.ON_STATUS_CHANGED, (e) => {
      console.log("ON_STATUS_CHANGED", e);
    });
  }

  clearListeners() {
    this.adMostOnReadyEvent.remove();
    this.adMostOnFailEvent.remove();
    this.adMostOnShownEvent.remove();
    this.adMostOnClickedEvent.remove();
    this.adMostOnDismissEvent.remove();
    this.adMostOnStatusChangedEvent.remove();
  }

  render() {
    return (
      <View style={{ flex:1 }}>
        <Button
          onPress={() => AdMostInterstitial.loadAd("zone-id")}
          title="Load Ad"
          color="red"
        />
      </View>
    );
  }
}
```


#### Methods
| Name             | Params             | Return  | Description                                                           |
|------------------|--------------------|---------|----------------------------------------|
| loadAd           | zoneId             | void    | Load ad                                |
| destroyAd        | zoneId             | void    | Destroy Ad                             |
| showAd           | zoneId             | promise | Show when ad is ready                  |
| isLoading        | zoneId             | promise | Ad is loading                          |
| isLoaded         | zoneId             | promise | Ad is loaded                           |

#### Events
| Name                 | Params                                            |
|----------------------|---------------------------------------------------|
| ON_READY             | network, ecpm, zoneId                             |
| ON_FAIL              | errorCode(Android), errorDescription(IOS), zoneId |
| ON_DISMISS           | message(Android), zoneId                          |
| ON_SHOWN             | network, zoneId                                   |
| ON_CLICKED           | network, zoneId                                   |
| ON_STATUS_CHANGED    | statusCode, zoneId                                |

### AdMostRewarded
```javascript
import React from "react";
import { Button, View } from "react-native";
import AdMost, { AdMostEventEmitter, AdMostRewarded, RewardedAdEvents } from "@up-inside/react-native-admost";

export default class SplashScreen extends React.Component {
  componentDidMount() {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
      userId: undefined,
    });

    this.setListeners();
  }

  componentWillUnmount() {
    this.clearListeners();
  }

  setListeners() {
    this.adMostOnReadyEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_READY, (e) => {
      console.log("ON_READY", e);
      AdMostRewarded.showAd();
    });

    this.adMostOnFailEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_FAIL, (e) => {
      console.log("ON_FAIL", e);
    });

    this.adMostOnShownEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_SHOWN, (e) => {
      console.log("ON_SHOWN", e);
    });

    this.adMostOnClickedEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_CLICKED, (e) => {
      console.log("ON_CLICKED", e);
    });

    this.adMostOnCompleteEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_COMPLETE, (e) => {
      console.log("ON_COMPLETE", e);
    });

    this.adMostOnDismissEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_DISMISS, (e) => {
      console.log("ON_DISMISS", e);
    });

    this.adMostOnStatusChangedEvent = AdMostEventEmitter.addListener(RewardedAdEvents.ON_STATUS_CHANGED, (e) => {
      console.log("ON_STATUS_CHANGED", e);
    });
  }

  clearListeners() {
    this.adMostOnReadyEvent.remove();
    this.adMostOnFailEvent.remove();
    this.adMostOnShownEvent.remove();
    this.adMostOnClickedEvent.remove();
    this.adMostOnCompleteEvent.remove();
    this.adMostOnDismissEvent.remove();
    this.adMostOnStatusChangedEvent.remove();
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <Button
          onPress={() => AdMostRewarded.loadAd("<zone-id>")}
          title="Load Ad"
          color="red"
        />
      </View>
    );
  }
}
```

#### Methods
| Name             | Params             | Return  | Description                                                           |
|------------------|--------------------|---------|----------------------------------------|
| loadAd           | zoneId             | void    | Load ad                                |
| destroyAd        | zoneId             | void    | Destroy Ad                             |
| showAd           | zoneId             | promise | Show when ad is ready                  |
| isLoading        | zoneId             | promise | Ad is loading                          |
| isLoaded         | zoneId             | promise | Ad is loaded                           |

#### Events
| Name                 | Params                                            |
|----------------------|---------------------------------------------------|
| ON_READY             | network, ecpm, zoneId                             |
| ON_FAIL              | errorCode(Android), errorDescription(IOS), zoneId |
| ON_DISMISS           | message(Android), zoneId                          |
| ON_COMPLETE          | network, zoneId                                   |
| ON_SHOWN             | network, zoneId                                   |
| ON_CLICKED           | network, zoneId                                   |
| ON_STATUS_CHANGED    | statusCode, zoneId                                |
