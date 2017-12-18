//
//  OCPhoto.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCPhoto.h"

@implementation OCPhoto

- (instancetype)initWithJSON:(id)photoJSON {
    self = [super init];
    if (self) {
        _farm = photoJSON[@"farm"];
        _server = photoJSON[@"server"];
        _identifier = photoJSON[@"id"];
        _secret = photoJSON[@"secret"];
    }
    
    return self;
}

- (NSURL *)photoURL {
    NSString *resultURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.farm, self.server, self.identifier, self.secret];
    
    return [NSURL URLWithString:resultURL];
}

@end
