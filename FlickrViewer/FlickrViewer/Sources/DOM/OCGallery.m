//
//  OCGallery.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCGallery.h"
#import "OCPhoto.h"

@implementation OCGallery

- (void)appendPhotos:(NSArray <OCPhoto*> * _Nullable )photosArray {
    if ([photosArray count] > 0) {
        _appendedPhotos = [photosArray copy];
        _photos = [_photos ?: @[] arrayByAddingObjectsFromArray:photosArray];
    }
}

- (void)updateWithJSON:(id)jsonDictionary {
    self.pagesCount = [jsonDictionary[@"pages"] integerValue];
    self.currentPage = [jsonDictionary[@"currentPage"] integerValue];
    
    self.totalPhotosCount = [jsonDictionary[@"total"] integerValue];
    
    NSMutableArray *photos = [NSMutableArray new];
    for (id dictionary in jsonDictionary[@"photo"]) {
        [photos addObject:[[OCPhoto alloc] initWithJSON:dictionary]];
    }
    
    [self appendPhotos:photos];
}

- (BOOL)hasMorePhoto {
    return self.photos.count < self.totalPhotosCount;
}

@end
