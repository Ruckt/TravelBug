//
//  Picture.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/12/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * pictureID;
@property (nonatomic, retain) NSString * standardLink;
@property (nonatomic, retain) NSString * thumbnailLink;
@property (nonatomic, retain) NSData * imageBinaryData;
@property (nonatomic, retain) Photographer *photographer;

@end
