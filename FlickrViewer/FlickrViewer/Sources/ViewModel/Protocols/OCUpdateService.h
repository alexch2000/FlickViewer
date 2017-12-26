//
//  OCUpdateProtocol.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/26/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCCancelable;
@class OCFlickrRequest;

NS_ASSUME_NONNULL_BEGIN

@protocol OCUpdateService <NSObject>

- (id<OCCancelable> _Nonnull)callForRequest:(OCFlickrRequest *)request finishBlock:(void(^ _Nullable)(id result, NSError *error))finishBlock;

@end

NS_ASSUME_NONNULL_END
