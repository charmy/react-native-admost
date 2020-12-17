import React from "react";
import { requireNativeComponent, UIManager, findNodeHandle, Platform } from "react-native";
import PropTypes from "prop-types";

const RCTAdMostAdView = requireNativeComponent("RCTAdMostAdView");

export default class AdMostAdView extends React.PureComponent {
  componentDidMount() {
    const { autoLoadDelayMs, autoLoad } = this.props;

    if (autoLoad) {
      this.loadTimeout = setTimeout(() => this.loadAd(), Math.max(100, autoLoadDelayMs));
    }
  }

  componentWillUnmount() {
    clearTimeout(this.loadTimeout);
    this.destroyAd();
  }

  loadAd() {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.rctAdMostAdView),
        Platform.OS === "ios" ? UIManager["RCTAdMostAdView"].Commands.loadAd : "loadAd",
        [],
    );
  }

  destroyAd() {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.rctAdMostAdView),
        Platform.OS === "ios" ? UIManager["RCTAdMostAdView"].Commands.destroyAd : "destroyAd",
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
  autoLoadDelayMs: PropTypes.number,
  layoutName: PropTypes.string,
  autoLoad: PropTypes.bool,
};

AdMostAdView.defaultProps = {
  autoLoadDelayMs: 100,
  autoLoad: true,
  layoutName: "DEFAULT",
};
