//
//  OCGalleryViewModelImplementation.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

@import Foundation;
#import "OCGalleryViewModel.h"

@protocol OCUpdateService;

@interface OCGalleryViewModelImplementation : NSObject <OCGalleryViewModel>

- (instancetype _Nonnull)initWithSearchService:(id<OCUpdateService> _Nonnull)service;

@end

