//
//  OCImageProvider.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/19/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCImageProvider.h"
#import "OCAsyncCall.h"
#import "OCDiskCache.h"

@interface OCImageProvider()

@property (nonatomic) NSURLSession *URLSession;
@property (nonatomic) NSCache *cache;
@property (nonatomic) OCDiskCache *diskCache;


@end

@implementation OCImageProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _diskCache = [OCDiskCache new];
        _cache = [[NSCache alloc] init];
        _cache.totalCostLimit = 100 * 1024 * 1024; // Limit on 100Mb;
    }
    
    return self;
}

- (BOOL)hasImageForURL:(NSURL *)URL {
    return [self.cache objectForKey:URL] != nil;
}

- (UIImage*)imageForURL:(NSURL *)URL {
    return [self.cache objectForKey:URL];
}

- (OCAsyncCall * _Nonnull)loadImageForURL:(NSURL *)URL finishBlock:(void(^ _Nullable)(UIImage* result, NSError *error))finishBlock {
    void(^localFinish)(NSData *data, NSError * error) = ^(NSData *data, NSError * error){
        UIImage *image = [[UIImage alloc] initWithData:data];
        if (error == nil) {
            if (finishBlock) {
                finishBlock(image, nil);
            }
            [self.cache setObject:image forKey:URL cost:[data length]];
        } else if (error.code != NSURLErrorCancelled) {
            if (finishBlock) {
                finishBlock(nil, error);
            }
        }
    };
    
    if ([self.diskCache hasCacheForURL:URL]) {
        [self.diskCache loadDataForURL:URL finishBlock:localFinish];
        return nil;
    }
    
    NSURLSessionDataTask *dataTask = [self.URLSession dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.diskCache cacheData:data forURL:URL];
        localFinish(data, error);
    }];
    [dataTask resume];
    
    return [[OCAsyncCall alloc] initWithTask:dataTask];
}

@end
