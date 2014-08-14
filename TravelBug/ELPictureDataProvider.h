//
//  ELPictureDataProvider.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/31/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELPictureDataProvider : NSObject

- (void)fetchPictures;
- (void)fetchPicturesWithCompletionHandler:(void(^)(NSArray* images, NSError *error))completionHandler;

- (void)downloadImageDataIntoObject:(NSArray *)pictures;

@end
