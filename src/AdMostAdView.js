import React from "react";
import { requireNativeComponent, UIManager, findNodeHandle, Platform } from "react-native";
import PropTypes from "prop-types";

const RCTAdMostAdView = requireNativeComponent("RCTAdMostAdView");

export default class AdMostAdView extends React.PureComponent {
  componentDidMount() {
    const { autoLoad } = this.props;

    if (autoLoad) {
      this.loadTimeout = setTimeout(() => this.loadAd(), 100);
    }
  }

  componentWillUnmount() {
    clearTimeout(this.loadTimeout);
  }

  loadAd() {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.rctAdMostAdView),
        Platform.OS === "ios" ? UIManager["RCTAdMostAdView"].Commands.loadAd : "loadAd",
        [],
    );
  }

  render() {
    const { zoneId, layoutName, style } = this.props;
    return (
        <RCTAdMostAdView
            ref={(ref) => (this.rctAdMostAdView = ref)}
            zoneId={zoneId}
            layoutName={layoutName}
            style={style}
        />
    );
  }
}

AdMostAdView.propTypes = {
  zoneId: PropTypes.string.isRequired,
  layoutName: PropTypes.string,
  autoLoad: PropTypes.bool,
};

AdMostAdView.defaultProps = {
  autoLoad: true,
  layoutName: "DEFAULT",
};
