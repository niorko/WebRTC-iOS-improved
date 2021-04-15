/*
 *  Copyright 2017 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "RTCDefaultVideoDecoderFactory.h"

#import "RTCH264ProfileLevelId.h"
#import "RTCVideoDecoderH264.h"
#import "api/video_codec/RTCVideoCodecConstants.h"
#if !defined(WEBRTC_CATALYST)
#import "api/video_codec/RTCVideoDecoderAV1.h"
#import "api/video_codec/RTCVideoDecoderVP8.h"
#import "api/video_codec/RTCVideoDecoderVP9.h"
#endif
#import "base/RTCVideoCodecInfo.h"

@implementation RTC_OBJC_TYPE (RTCDefaultVideoDecoderFactory)

- (NSArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *)supportedCodecs {
  NSDictionary<NSString *, NSString *> *constrainedHighParams = @{
    @"profile-level-id" : kRTCMaxSupportedH264ProfileLevelConstrainedHigh,
    @"level-asymmetry-allowed" : @"1",
    @"packetization-mode" : @"1",
  };
  RTC_OBJC_TYPE(RTCVideoCodecInfo) *constrainedHighInfo =
      [[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecH264Name
                                                  parameters:constrainedHighParams];

  NSDictionary<NSString *, NSString *> *constrainedBaselineParams = @{
    @"profile-level-id" : kRTCMaxSupportedH264ProfileLevelConstrainedBaseline,
    @"level-asymmetry-allowed" : @"1",
    @"packetization-mode" : @"1",
  };
  RTC_OBJC_TYPE(RTCVideoCodecInfo) *constrainedBaselineInfo =
      [[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecH264Name
                                                  parameters:constrainedBaselineParams];

  #if !defined(WEBRTC_CATALYST)
  RTC_OBJC_TYPE(RTCVideoCodecInfo) *vp8Info =
      [[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecVp8Name];
  #endif

  NSMutableArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *result = [@[
    constrainedHighInfo,
    constrainedBaselineInfo,
    #if !defined(WEBRTC_CATALYST)
    vp8Info,
    #endif
  ] mutableCopy];

  #if !defined(WEBRTC_CATALYST)
  if ([RTC_OBJC_TYPE(RTCVideoDecoderVP9) isSupported]) {
    [result
        addObject:[[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecVp9Name]];
  }

  if ([RTC_OBJC_TYPE(RTCVideoDecoderAV1) isSupported]) {
    [result
        addObject:[[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecAv1Name]];
  }
  #endif

  return result;
}

- (id<RTC_OBJC_TYPE(RTCVideoDecoder)>)createDecoder:(RTC_OBJC_TYPE(RTCVideoCodecInfo) *)info {
  if ([info.name isEqualToString:kRTCVideoCodecH264Name]) {
    return [[RTC_OBJC_TYPE(RTCVideoDecoderH264) alloc] init];
  } 
  #if !defined(WEBRTC_CATALYST)
  else if ([info.name isEqualToString:kRTCVideoCodecVp8Name]) {
    return [RTC_OBJC_TYPE(RTCVideoDecoderVP8) vp8Decoder];
  }
  else if ([info.name isEqualToString:kRTCVideoCodecVp9Name] &&
             [RTC_OBJC_TYPE(RTCVideoDecoderVP9) isSupported]) {
    return [RTC_OBJC_TYPE(RTCVideoDecoderVP9) vp9Decoder];
  }
  else if ([info.name isEqualToString:kRTCVideoCodecAv1Name] &&
             [RTC_OBJC_TYPE(RTCVideoDecoderAV1) isSupported]) {
    return [RTC_OBJC_TYPE(RTCVideoDecoderAV1) av1Decoder];
  }
  #endif

  return nil;
}

@end
