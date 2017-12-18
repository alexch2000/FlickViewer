//
//  OCFlickrRequest+Search.m
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrRequest+Search.h"

@implementation OCFlickrRequest (Search)

+ (instancetype)requestForText:(NSString *)text pageNumber:(NSInteger)pageNumber {
    NSParameterAssert(text);
    if ([text length] > 0) {
        return [[OCFlickrRequest alloc] initWithMethod:@"flickr.photos.search" queryParameters:@{
                                                                                                 @"text" : text,
                                                                                                 @"page" :[@(pageNumber) stringValue]
                                                                                                 }
                ];
    }
    return nil;
}


@end
