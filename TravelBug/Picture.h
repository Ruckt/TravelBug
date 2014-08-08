//
//  Picture.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/5/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Picture : NSManagedObject

@property (nonatomic, retain) NSNumber * pictureID;
@property (nonatomic, retain) NSString * standardLink;
@property (nonatomic, retain) NSString * thumbnailLink;
@property (nonatomic, retain) NSString * location;

@end
