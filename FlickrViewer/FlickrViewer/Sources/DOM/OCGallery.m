//
//  OCGallery.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCGallery.h"

@implementation OCGallery

- (void)appendPhotos:(NSArray <OCPhoto*> * _Nullable )photosArray {
    if ([photosArray count] > 0) {
        _appendedPhotos = [photosArray copy];
        _photos = [_photos ?: @[] arrayByAddingObjectsFromArray:photosArray];
    }
}

@end
