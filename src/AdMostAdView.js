import React from "react";
import { requireNativeComponent, UIManager, findNodeHandle } from "react-native";
import PropTypes from "prop-types";

const RCTAdMostAdView = requireNativeComponent("RCTAdMostAdView");

export default class AdMostAdView extends React.PureComponent {
  componentDidMount() {
    const { autoLoad } = this.props;

    if (autoLoad) {
      setTimeout(() => this.loadAd(), 100);
    }
  }

  loadAd() {
    UIManager.dispatchViewManagerCommand(
        findNodeHandle(this.rctAdMostAdView),
        UIManager["RCTAdMostAdView"].Commands.loadAd,
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
