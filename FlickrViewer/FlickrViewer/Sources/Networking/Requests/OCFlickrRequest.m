//
//  OCFlickrRequest.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrRequest.h"

@implementation OCFlickrRequest

- (instancetype)initWithMethod:(NSString *)method queryParameters:(NSDictionary * _Nullable)queryParameters {
    self = [super init];
    if (self) {
        _method = [method copy];
        _queryParameters = [queryParameters copy];
    }
    
    return self;
}

+ (instancetype)requestWithMethod:(NSString *)method queryParameters:(NSDictionary * _Nullable)queryParameters {
    return [[self alloc] initWithMethod:method queryParameters:queryParameters];
}

@end

