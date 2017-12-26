//
//  OCGalleryViewModelImplementation.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCGalleryViewModelImplementation.h"
#import "OCAsyncCall.h"

#import "OCGallery.h"
#import "OCFlickrRequest+Search.h"
#import "OCFlickrService.h"
#import "OCPhoto.h"

@interface OCGalleryViewModelImplementation()

@property (nonatomic) id<OCCancelable> latestSearch;
@property (nonatomic) id<OCUpdateService> service;

@property (nonatomic) OCGallery *gallery;

@end

@implementation OCGalleryViewModelImplementation

@synthesize delegate = _delegate;
@synthesize latestError = _latestError;

@synthesize searchText = _searchText;

- (instancetype)initWithSearchService:(OCFlickrService * _Nonnull)service {
    self = [super init];
    if (self) {
        _service = service;
    }
    
    return self;
}

- (NSArray *)photos {
    return self.gallery.photos;
}

- (void)cleanupGallery {
    self.gallery = nil;
}

- (void)newSearchForText:(NSString *)text {
    [self.latestSearch cancel];
    [self cleanupGallery];
    _searchText = [text copy];
    if (text.length > 0) {
        self.latestSearch = [self.service callForRequest:[OCFlickrRequest requestForText:text pageNumber:1] finishBlock:^(id  _Nonnull result, NSError * _Nonnull error) {
            [self parseData:result error:error];
            self.gallery.searchText = text;
            self.latestSearch = nil;
        }];
        
        
    }
    if ([self.delegate respondsToSelector:@selector(galleryViewModelDidStartNewSearch:)]) {
        [self.delegate galleryViewModelDidStartNewSearch:self];
    }
}

- (void)loadNextPage {
    if (self.gallery.hasMorePhoto && self.latestSearch == nil) {
        self.latestSearch = [self.service callForRequest:[OCFlickrRequest requestForText:self.gallery.searchText pageNumber:self.gallery.currentPage + 1] finishBlock:^(id  _Nonnull result, NSError * _Nonnull error) {
            [self parseData:result error:error];
            self.latestSearch = nil;
        }];
    }
}

- (void)parseData:(id)result error:(NSError*)error {
    if (error == nil) {
        if (self.gallery == nil) {
            self.gallery = [[OCGallery alloc] init];
        }
        
        [self.gallery updateWithJSON:result[@"photos"]];
        if ([self.delegate respondsToSelector:@selector(galleryViewModel:didAppendPhotos:)]) {
            [self.delegate galleryViewModel:self didAppendPhotos:self.gallery.appendedPhotos];
        }
    } else {
        self.latestError = error;
        if ([self.delegate respondsToSelector:@selector(gallertViewModel:didFailSearchWithError:)]) {
            [self.delegate gallertViewModel:self didFailSearchWithError:error];
        }
    }
}

@end

