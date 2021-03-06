/*
 *  Copyright 2017 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "RTCDefaultVideoEncoderFactory.h"

#import "RTCH264ProfileLevelId.h"
#import "RTCVideoEncoderH264.h"
#import "api/video_codec/RTCVideoCodecConstants.h"
#if !defined(WEBRTC_CATALYST)
#import "api/video_codec/RTCVideoEncoderVP8.h"
#endif
#import "base/RTCVideoCodecInfo.h"
#if defined(RTC_ENABLE_VP9)
#import "api/video_codec/RTCVideoEncoderVP9.h"
#endif

@implementation RTC_OBJC_TYPE (RTCDefaultVideoEncoderFactory)

@synthesize preferredCodec;

+ (NSArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *)supportedCodecs {
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

#if defined(RTC_ENABLE_VP9)
  RTC_OBJC_TYPE(RTCVideoCodecInfo) *vp9Info =
      [[RTC_OBJC_TYPE(RTCVideoCodecInfo) alloc] initWithName:kRTCVideoCodecVp9Name];
#endif

  return @[
    constrainedHighInfo,
    constrainedBaselineInfo,
#if !defined(WEBRTC_CATALYST)
    vp8Info,
#endif
#if defined(RTC_ENABLE_VP9)
    vp9Info,
#endif
  ];
}

- (id<RTC_OBJC_TYPE(RTCVideoEncoder)>)createEncoder:(RTC_OBJC_TYPE(RTCVideoCodecInfo) *)info {
  if ([info.name isEqualToString:kRTCVideoCodecH264Name]) {
    return [[RTC_OBJC_TYPE(RTCVideoEncoderH264) alloc] initWithCodecInfo:info];
#if !defined(WEBRTC_CATALYST)
  } else if ([info.name isEqualToString:kRTCVideoCodecVp8Name]) {
    return [RTC_OBJC_TYPE(RTCVideoEncoderVP8) vp8Encoder];
#endif
#if defined(RTC_ENABLE_VP9)
  } else if ([info.name isEqualToString:kRTCVideoCodecVp9Name]) {
    return [RTC_OBJC_TYPE(RTCVideoEncoderVP9) vp9Encoder];
#endif
  }

  return nil;
}

- (NSArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *)supportedCodecs {
  NSMutableArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *codecs =
      [[[self class] supportedCodecs] mutableCopy];

  NSMutableArray<RTC_OBJC_TYPE(RTCVideoCodecInfo) *> *orderedCodecs = [NSMutableArray array];
  NSUInteger index = [codecs indexOfObject:self.preferredCodec];
  if (index != NSNotFound) {
    [orderedCodecs addObject:[codecs objectAtIndex:index]];
    [codecs removeObjectAtIndex:index];
  }
  [orderedCodecs addObjectsFromArray:codecs];

  return [orderedCodecs copy];
}

@end
