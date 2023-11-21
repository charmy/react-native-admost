#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_REMAP_MODULE(AdMostRewarded, AdMostRewardedModule, NSObject)

RCT_EXTERN_METHOD(loadAd:
                  (nonnull NSString) zoneId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(destroyAd:
                  (nonnull NSString) zoneId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(showAd:
                  (nonnull NSString) zoneId
                  tag:(nonnull NSString) adTag
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(isLoading:
                  (nonnull NSString) zoneId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(isLoaded:
                  (nonnull NSString) zoneId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
@end
