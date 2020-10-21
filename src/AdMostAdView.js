import React from "react";
import { requireNativeComponent, UIManager, findNodeHandle, Platform } from "react-native";
import PropTypes from "prop-types";

const RCTAdMostAdView = requireNativeComponent("RCTAdMostAdView");

export default class AdMostAdView extends React.PureComponent {
  componentDidMount() {
    const { autoLoad } = this.props;

    if (autoLoad) {
      if (Platform.OS === "ios") {
        this.iosLoadTimeout = setTimeout(() => this.loadAd(), 100);
      }

      if (Platform.OS === "android") {
        this.loadAd();
      }
    }
  }

  componentWillUnmount() {
    clearTimeout(this.iosLoadTimeout);
  }

  loadAd() {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.rctAdMostAdView),
        Platform.OS === "ios" ? UIManager["RCTAdMostAdView"].Commands.loadAd : "loadAd",
        [],
    );
  }

  render() {
    const { zoneId, style } = this.props;
    return <RCTAdMostAdView ref={(ref) => (this.rctAdMostAdView = ref)} zoneId={zoneId} style={style} />;
  }
}

AdMostAdView.propTypes = {
  zoneId: PropTypes.string,
  autoLoad: PropTypes.bool,
};

AdMostAdView.defaultProps = {
  autoLoad: true,
};
