//
//  OCAsyncCall.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCAsyncCall.h"

@interface OCAsyncCall ()
@property (nonatomic) NSURLSessionTask *backTask;
@end

@implementation OCAsyncCall

- (instancetype)initWithTask:(NSURLSessionTask *)task {
    NSParameterAssert(task);
    self = [super init];
    if (self) {
        _backTask = task;
    }
    
    return self;
}

- (void)cancel {
    if (_backTask.state == NSURLSessionTaskStateRunning) {
        [_backTask cancel];
    }
}

@end
