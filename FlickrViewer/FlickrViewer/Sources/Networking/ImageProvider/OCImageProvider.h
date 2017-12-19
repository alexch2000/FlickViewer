//
//  OCImageProvider.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/19/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import UIKit;
@class OCAsyncCall;

NS_ASSUME_NONNULL_BEGIN

@interface OCImageProvider : NSObject

- (BOOL)hasImageForURL:(NSURL *)URL;
- (UIImage*)imageForURL:(NSURL *)URL;
- (OCAsyncCall * _Nonnull)loadImageForURL:(NSURL *)URL finishBlock:(void(^ _Nullable)(UIImage* result, NSError *error))finishBlock;

@end

NS_ASSUME_NONNULL_END
