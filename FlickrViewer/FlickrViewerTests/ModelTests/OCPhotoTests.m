//
//  OCPhotoTests.m
//  FlickrViewerTests
//
//  Created by Oleksii Chopyk on 12/25/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCPhoto.h"

@interface OCPhotoTests : XCTestCase

@end

@implementation OCPhotoTests

- (void)testWrongInitializing {
    XCTAssertThrows([[OCPhoto alloc] initWithJSON:@{}]);
}

- (void)testInitWithJSON {
    NSString *photoId = @"asdfasdf";
    NSString *secret = @"secret";
    NSInteger server = 123123;
    NSInteger farm = 5;
    NSDictionary *photoJSON = @{
                                @"farm"  : @(farm),
                                @"id" :photoId,
                                @"secret" : secret,
                                @"server" : @(server),
                                };
    OCPhoto *photo = [[OCPhoto alloc] initWithJSON:photoJSON];
    XCTAssertNotNil(photo);
    XCTAssertEqual(photo.identifier, photoId);
}

- (void)testPhotoURL {
    OCPhoto *photo = [[OCPhoto alloc] initWithJSON:@{
                                                     @"farm"  : @(4),
                                                     @"id" : @"123123",
                                                     @"secret" : @"secret",
                                                     @"server" : @"server",
                                                     }];
    NSURL *URL = [NSURL URLWithString:@"https://farm4.staticflickr.com/server/123123_secret.jpg"];
    XCTAssertTrue([photo.photoURL isEqual:URL]);
}

@end
