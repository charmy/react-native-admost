#import <React/RCTBridgeModule.h>
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_REMAP_MODULE(AdMost, AdMostModule, RCTEventEmitter)

RCT_EXTERN_METHOD(initAdMost:
                  (nonnull NSDictionary) config
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(setUserId: (nonnull NSString) userId)
RCT_EXTERN_METHOD(setCanRequestAds: (nonnull BOOL) canRequestsAds)
RCT_EXTERN_METHOD(trackIAP: (nonnull NSDictionary) data)
@end
