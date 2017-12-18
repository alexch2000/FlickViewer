//
//  OCPhoto.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCPhoto : NSObject

- (instancetype)initWithJSON:(id)photoJSON;

@property (nonatomic, readonly) NSString *farm;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *secret;

@end
