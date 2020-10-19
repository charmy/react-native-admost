#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_REMAP_MODULE(AdMost, AdMostModule, NSObject)

RCT_EXTERN_METHOD(initAdMost:
    (nonnull NSDictionary) config
        resolver:(RCTPromiseResolveBlock)resolve
        rejecter:(RCTPromiseRejectBlock)reject)
@end
