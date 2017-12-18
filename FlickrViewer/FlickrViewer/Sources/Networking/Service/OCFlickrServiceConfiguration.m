//
//  OCFlickrServiceConfiguration.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrServiceConfiguration.h"

@implementation OCFlickrServiceConfiguration

- (instancetype)initWithAppToken:(NSString *)appToken {
    NSParameterAssert(appToken);
    self = [super init];
    if (self) {
        _appToken = appToken;
    }
    
    return self;
}

@end
