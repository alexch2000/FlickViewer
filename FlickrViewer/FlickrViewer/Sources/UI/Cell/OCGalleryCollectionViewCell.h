//
//  OCGalleryCollectionViewCell.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OCImageProvider;

NS_ASSUME_NONNULL_BEGIN

@interface OCGalleryCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly, nullable) UIImage *image;
@property (nonatomic, copy, nullable) NSURL *imageURL;

@property (nonatomic) OCImageProvider *imageProvider;

@end

NS_ASSUME_NONNULL_END
