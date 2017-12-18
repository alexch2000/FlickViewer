//
//  OCFlickrRequest+Search.h
//  FlickrViewer
//
//  Created by Oleksii Chopyk on 12/18/17.
//  Copyright © 2017 Oleksii Chopyk. All rights reserved.
//

#import "OCFlickrRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCFlickrRequest (Search)

+ (instancetype)requestForText:(NSString *)text pageNumber:(NSInteger)pageNumber;

@end

NS_ASSUME_NONNULL_END
