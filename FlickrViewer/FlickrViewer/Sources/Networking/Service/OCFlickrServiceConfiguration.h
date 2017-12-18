//
//  OCFlickrServiceConfiguration.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCFlickrServiceConfiguration : NSObject

- (instancetype)initWithAppToken:(NSString *)appToken;

@property (nonatomic, readonly, copy) NSString *appToken;

@end

NS_ASSUME_NONNULL_END
