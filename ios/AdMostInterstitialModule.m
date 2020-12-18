#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_REMAP_MODULE(AdMostInterstitial, AdMostInterstitialModule, NSObject)

RCT_EXTERN_METHOD(loadAd:
                  (nonnull NSString) zoneId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(showAd:
                  (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(isLoading:
                  (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(isLoaded:
                  (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
@end
