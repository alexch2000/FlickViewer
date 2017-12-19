//
//  OCDiskCache.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/19/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface OCDiskCache : NSObject

- (BOOL)hasCacheForURL:(NSURL *)URL;
- (void)loadDataForURL:(NSURL *)URL finishBlock:(void(^ _Nullable)(NSData* result, NSError *error))finishBlock;
- (void)cacheData:(NSData *)data forURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
