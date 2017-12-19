//
//  OCFlickrService.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrService.h"
#import "OCFlickrServiceConfiguration.h"
#import "OCFlickrRequest.h"

#import "OCAsyncCall.h"

static NSString *const sBaseURLString = @"https://api.flickr.com/services/rest/";

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

- (OCAsyncCall * _Nonnull)callForRequest:(OCFlickrRequest *)request finishBlock:(void(^)(id result, NSError *error))finishBlock {
    NSParameterAssert(request);
    NSURLSessionTask *task = [self dataTaskFromRequest:request finishBlock:finishBlock];
    [task resume];
    NSLog(@"Request ==> %@", task.originalRequest.URL);
    
    return [[OCAsyncCall alloc] initWithTask:task];
}


- (NSURLSessionDataTask *)dataTaskFromRequest:(OCFlickrRequest *)request finishBlock:(void(^)(id result, NSError *error))finishBlock {
    NSURLRequest *URLRequest = [self URLRequestFromAPIRequest:request];
    NSURLSessionDataTask *dataTask = [_URLSession dataTaskWithRequest:URLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            if (finishBlock) {
                finishBlock(nil, error);
            }
        } else {
            dispatch_async(self.parsingQueue, ^(void) {
                NSError *parsingError = nil;
                id resultObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parsingError];
                if (finishBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        finishBlock(resultObject, parsingError);
                    });
                }
            });
        }
    }];
    
    return dataTask;
}

- (NSURLRequest *)URLRequestFromAPIRequest:(OCFlickrRequest *)request {
    NSMutableDictionary *resultParametersDictionary = [request.queryParameters mutableCopy];
    resultParametersDictionary[@"api_key"] = self.configuration.appToken;
    resultParametersDictionary[@"format"] = @"json";
    resultParametersDictionary[@"method"] = request.method;
    resultParametersDictionary[@"nojsoncallback"] = @"1";
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:sBaseURLString] resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = [NSMutableArray new];
    [resultParametersDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
    }];
    components.queryItems = queryItems;
    return [NSURLRequest requestWithURL:components.URL];
}

@end

