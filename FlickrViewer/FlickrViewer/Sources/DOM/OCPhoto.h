//
//  OCPhoto.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCPhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCPhoto : NSObject <OCPhotoViewModel>

- (instancetype)initWithJSON:(id)photoJSON;

@property (nonatomic, readonly) NSString *farm;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *secret;

@end

NS_ASSUME_NONNULL_END
