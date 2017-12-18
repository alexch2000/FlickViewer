//
//  OCFlickrService.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import Foundation;
@class OCFlickrServiceConfiguration, OCAsyncCall, OCFlickrRequest;

NS_ASSUME_NONNULL_BEGIN

@interface OCFlickrService : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithConfiguration:(OCFlickrServiceConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (OCAsyncCall * _Nonnull)callForRequest:(OCFlickrRequest *)request finishBlock:(void(^ _Nullable)(id result, NSError *error))finishBlock;

@end

NS_ASSUME_NONNULL_END

