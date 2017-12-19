//
//  OCGalleryViewController.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCGalleryViewModel;
@class OCImageProvider;

NS_ASSUME_NONNULL_BEGIN

@interface OCGalleryViewController : UIViewController

- (instancetype)initWithViewModel:(id<OCGalleryViewModel>)viewModel imageProvider:(OCImageProvider *)imageProvider;
@property (nonatomic, readonly) id<OCGalleryViewModel> galleryViewModel;

@end

NS_ASSUME_NONNULL_END
