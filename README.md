# react-native-admost


```
import AdMost, { AdMostAdView } from "@up-inside/react-native-admost";

export default class App extends React.Component {
  componentDidMount() {
    const appId = "<your-app-id>";

    AdMost.initAdMost({
      appId: appId,
      userConsent: true,
      subjectToGDPR: false,
      subjectToCCPA: false,
      userChild: false,
    });
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <AdMostAdView style={{ width: "100%", height: 250 }} zoneId="<your-zone-id>" />
      </View>
    );
  }
}
```