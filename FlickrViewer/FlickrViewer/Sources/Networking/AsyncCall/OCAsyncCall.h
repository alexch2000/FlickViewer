//
//  OCAsyncCall.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCAsyncCall : NSObject

- (instancetype _Nonnull)initWithTask:(NSURLSessionTask *)taks;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
