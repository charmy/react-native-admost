import React, { memo, useCallback, useEffect, useRef } from "react";
import {
  UIManager,
  Platform,
  findNodeHandle,
  requireNativeComponent,
  type ViewStyle,
  type NativeSyntheticEvent,
} from "react-native";

interface RCTAdMostAdViewProps {
  zoneId: string;
  layoutName?: string;
  tag?: string;
  style: ViewStyle;

  onReady?: (e: NativeSyntheticEvent<{ network: string; ecpm: number; zoneId: string }>) => void;
  onFail?: (e: NativeSyntheticEvent<{ errorCode: number; zoneId: string }>) => void;
  onClick?: (e: NativeSyntheticEvent<{ network: string; zoneId: string }>) => void;
}

export interface AdMostAdViewProps extends RCTAdMostAdViewProps {
  autoLoadDelayMs?: number;
}

const RCTComponentName = "RCTAdMostAdView";
const RCTAdMostAdView = requireNativeComponent<RCTAdMostAdViewProps>(RCTComponentName);

function AdMostAdView({
  zoneId,
  layoutName = "DEFAULT",
  tag = "",
  style,
  onReady,
  onFail,
  onClick,

  autoLoadDelayMs = 100,
}: AdMostAdViewProps) {
  const rctAdMostAdViewRef = useRef<any>(null);

  useEffect(() => {
    const loadTimeout = setTimeout(() => loadAd(), Math.max(100, autoLoadDelayMs));

    return () => {
      clearTimeout(loadTimeout);
      destroyAd();
    };
  }, []);

  const loadAd = useCallback(() => {
    const viewId = findNodeHandle(rctAdMostAdViewRef.current);
    const commandId =
      Platform.OS === "ios" ? UIManager.getViewManagerConfig(RCTComponentName).Commands.loadAd : "loadAd";

    if (commandId !== undefined && viewId !== null) {
      UIManager.dispatchViewManagerCommand(viewId, commandId, []);
    }
  }, [rctAdMostAdViewRef.current]);

  const destroyAd = useCallback(() => {
    const viewId = findNodeHandle(rctAdMostAdViewRef.current);
    const commandId =
      Platform.OS === "ios" ? UIManager.getViewManagerConfig(RCTComponentName).Commands.destroyAd : "destroyAd";

    if (commandId !== undefined && viewId !== null) {
      UIManager.dispatchViewManagerCommand(viewId, commandId, []);
    }
  }, [rctAdMostAdViewRef.current]);

  return (
    <RCTAdMostAdView
      ref={rctAdMostAdViewRef}
      zoneId={zoneId}
      layoutName={layoutName}
      tag={tag}
      style={style}
      onReady={onReady}
      onFail={onFail}
      onClick={onClick}
    />
  );
}

export default memo(AdMostAdView);
