#import "React/RCTViewManager.h"

@interface RCT_EXTERN_REMAP_MODULE(RCTAdMostAdView, AdMostAdViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(zoneId, NSString)

RCT_REMAP_VIEW_PROPERTY(tag, nsTag, NSString)

RCT_EXPORT_VIEW_PROPERTY(layoutName, NSString)

RCT_EXTERN_METHOD(loadAd:(nonnull NSNumber *)node)

RCT_EXTERN_METHOD(destroyAd:(nonnull NSNumber *)node)

RCT_EXPORT_VIEW_PROPERTY(onReady, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onFail, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)

@end
