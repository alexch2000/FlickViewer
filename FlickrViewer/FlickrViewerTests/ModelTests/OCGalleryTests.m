//
//  OCGalleryTests.m
//  FlickrViewerTests
//
//  Created by Oleksii Chopyk on 12/25/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCGallery.h"

@interface OCGalleryTests : XCTestCase

@end

@implementation OCGalleryTests

- (void)testJSONInitialization {
    NSInteger totalCount = 1000;
    NSInteger page = 1;
    NSInteger pages = 10;
    NSInteger perpage = 100;
    
    NSDictionary *galerryDictionary = @{@"total" : @(totalCount),
                                        @"page"  : @(page),
                                        @"perpage" : @(perpage),
                                        @"pages" : @(pages),
                                        @"photo" : @[
                                                @{
                                                @"farm"  : @(5),
                                                @"id" : @"123123123",
                                                @"secret" : @"evadsfsadf",
                                                @"server" : @(30303),
                                                }
                                                ],
                                        };
    
    OCGallery *gallery = [[OCGallery alloc] init];
    [gallery updateWithJSON:galerryDictionary];
    XCTAssertTrue(gallery.totalPhotosCount == totalCount);
    XCTAssertTrue(gallery.photos.count == 1);
}

- (void)testSecondUpdate {
    NSInteger totalCount = 1000;
    NSInteger page = 1;
    NSInteger pages = 10;
    NSInteger perpage = 100;
    
    NSDictionary *galerryDictionary = @{@"total" : @(totalCount),
                                        @"page"  : @(page),
                                        @"perpage" : @(perpage),
                                        @"pages" : @(pages),
                                        @"photo" : @[
                                                @{
                                                    @"farm"  : @(5),
                                                    @"id" : @"123123123",
                                                    @"secret" : @"evadsfsadf",
                                                    @"server" : @(30303),
                                                    }
                                                ],
                                        };
    
    OCGallery *gallery = [[OCGallery alloc] init];
    [gallery updateWithJSON:galerryDictionary];
    XCTAssertTrue(gallery.totalPhotosCount == totalCount);
    XCTAssertTrue(gallery.photos.count == 1);
    NSDictionary *secondGalerryDictionary = @{@"total" : @(totalCount),
                                        @"page"  : @(2),
                                        @"perpage" : @(perpage),
                                        @"pages" : @(pages),
                                        @"photo" : @[
                                                @{
                                                    @"farm"  : @(5),
                                                    @"id" : @"123123123",
                                                    @"secret" : @"evadsfsadf",
                                                    @"server" : @(30303),
                                                    }
                                                ],
                                        };
    
    [gallery updateWithJSON:secondGalerryDictionary];
    XCTAssertTrue(gallery.totalPhotosCount == totalCount);
    XCTAssertTrue(gallery.photos.count == 2);
}

@end
