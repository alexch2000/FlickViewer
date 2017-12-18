//
//  OCFlickrService.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrService.h"
#import "OCAsyncCall.h"
#import "OCFlickrRequest.h"


@interface OCFlickrService()

@property (nonatomic) OCFlickrServiceConfiguration *configuration;
@property (nonatomic) NSURLSession *URLSession;
@property (nonatomic) dispatch_queue_t parsingQueue;

@end

@implementation OCFlickrService

- (instancetype)initWithConfiguration:(OCFlickrServiceConfiguration *)configuration {
    NSParameterAssert(configuration);
    
    if (configuration == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _configuration = configuration;
        _parsingQueue = dispatch_queue_create("com.session.queue", DISPATCH_QUEUE_CONCURRENT);
        _URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (OCAsyncCall * _Nonnull)callForRequest:(OCFlickrRequest *)request finishBlock:(void(^ _Nullable)(id result, NSError *error))finishBlock {
    NSParameterAssert(request);
    return nil;

}

@end
