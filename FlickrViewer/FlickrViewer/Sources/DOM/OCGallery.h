//
//  OCGallery.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface OCGallery : NSObject

@property (nonatomic) NSInteger totalPhotosCount;
@property (nonatomic) NSInteger pagesCount;
@property (nonatomic) NSInteger currentPage;

@property (nonatomic, copy, nullable) NSString *searchText;

@property (nonatomic, readonly, nullable) NSArray <OCPhoto *> * photos;

@property (nonatomic, readonly, nullable) NSArray <OCPhoto *> * appendedPhotos;
- (void)appendPhotos:(NSArray <OCPhoto*> * _Nullable )photosArray;

@end

NS_ASSUME_NONNULL_END
