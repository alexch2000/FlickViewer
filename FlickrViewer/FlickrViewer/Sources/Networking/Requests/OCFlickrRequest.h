//
//  OCFlickrRequest.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCFlickrRequest : NSObject

- (instancetype)initWithMethod:(NSString *)apiCall queryParameters:(NSDictionary * _Nullable)queryParameters;
+ (instancetype)requestWithMethod:(NSString *)method queryParameters:(NSDictionary * _Nullable)queryParameters;

@property (nonatomic, readonly, copy) NSString *method;
@property (nonatomic, readonly, copy, nullable) NSDictionary *queryParameters;


@end

NS_ASSUME_NONNULL_END
