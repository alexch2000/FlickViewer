//
//  OCDiskCache.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/19/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCDiskCache.h"

@interface OCDiskCache()

@property (nonatomic) dispatch_queue_t workingQueue;
@property (nonatomic) NSString *folder;

@end

@implementation OCDiskCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _workingQueue = dispatch_queue_create("com.oc.diskcache", DISPATCH_QUEUE_CONCURRENT);
        _folder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    }
    
    return self;
}



- (NSString *)filePathForURL:(NSURL *)URL {
    return [self.folder stringByAppendingString:[[URL absoluteString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet illegalCharacterSet]]];
}

- (BOOL)hasCacheForURL:(NSURL *)URL {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self filePathForURL:URL]];
}

- (void)loadDataForURL:(NSURL *)URL finishBlock:(void(^ _Nullable)(NSData* result, NSError *error))finishBlock {
    dispatch_async(self.workingQueue, ^(void) {
        NSData *data = [NSData dataWithContentsOfFile:[self filePathForURL:URL]];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (finishBlock) {
                finishBlock(data, nil);
            }
        });
    });
}

- (void)cacheData:(NSData *)data forURL:(NSURL *)URL {
    dispatch_async(self.workingQueue, ^(void) {
        [data writeToFile:[self filePathForURL:URL] atomically:YES];
    });

}


@end
