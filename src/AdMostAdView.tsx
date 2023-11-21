import React, { useCallback, useEffect, useRef } from "react";
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

  onReady: (e: NativeSyntheticEvent<{ network: string; ecpm: number; zoneId: string }>) => void;
  onFail: (e: NativeSyntheticEvent<{ errorCode: number; zoneId: string }>) => void;
  onClick: (e: NativeSyntheticEvent<{ network: string; zoneId: string }>) => void;
}

interface AdMostAdViewProps extends RCTAdMostAdViewProps {
  autoLoadDelayMs?: number;
  autoLoad?: boolean;
}

const RCTComponentName = "RCTAdMostAdView";
const RCTAdMostAdView = requireNativeComponent<RCTAdMostAdViewProps>(RCTComponentName);

export default function AdMostAdViewProps({
  zoneId,
  layoutName = "DEFAULT",
  tag = "",
  style,
  onReady,
  onFail,
  onClick,

  autoLoadDelayMs = 100,
  autoLoad = true,
}: AdMostAdViewProps) {
  const rctAdMostAdViewRef = useRef<any>(null);

  useEffect(() => {
    let loadTimeout: any;
    if (autoLoad) {
      loadTimeout = setTimeout(() => loadAd(), Math.max(100, autoLoadDelayMs));
    }

    return () => {
      clearTimeout(loadTimeout);
      destroyAd();
    };
  }, []);

  const loadAd = useCallback(() => {
    // @ts-ignore
    const commandId = Platform.OS === "ios" ? UIManager[RCTComponentName].Commands.loadAd : "loadAd";
    UIManager.dispatchViewManagerCommand(findNodeHandle(rctAdMostAdViewRef.current), commandId, []);
  }, [rctAdMostAdViewRef.current]);

  const destroyAd = useCallback(() => {
    // @ts-ignore
    const commandId = Platform.OS === "ios" ? UIManager[RCTComponentName].Commands.destroyAd : "destroyAd";
    UIManager.dispatchViewManagerCommand(findNodeHandle(rctAdMostAdViewRef.current), commandId, []);
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
