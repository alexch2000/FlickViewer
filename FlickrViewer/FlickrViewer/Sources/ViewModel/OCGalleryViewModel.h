//
//  OCGalleryViewModel.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@protocol OCPhotoViewModel, OCGalleryViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol OCGalleryViewModelDelegate <NSObject>

@optional
- (void)galleryViewModelDidStartNewSearch:(id<OCGalleryViewModel>)model;
- (void)gallertViewModel:(id<OCGalleryViewModel>)model didFailSearchWithError:(NSError * _Nullable)error;
- (void)galleryViewModel:(id<OCGalleryViewModel>)model didAppendPhotos:(NSArray<id<OCPhotoViewModel>>* _Nullable )photos;

@end

@protocol OCGalleryViewModel <NSObject>

@property (nonatomic, weak, nullable) id<OCGalleryViewModelDelegate> delegate;
@property (nonatomic, nullable, readonly) NSArray< id<OCPhotoViewModel> >* photos;
@property (nonatomic, nullable) NSError *latestError;

@property (nonatomic, readonly, nullable) NSString *searchText;

- (void)newSearchForText:(NSString * _Nullable)text;
- (void)loadNextPage;

@end

NS_ASSUME_NONNULL_END
