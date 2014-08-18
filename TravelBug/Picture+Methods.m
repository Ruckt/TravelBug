//
//  Picture+Methods.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/30/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "Picture+Methods.h"

@implementation Picture (Methods)


+(Picture *) pictureID:(NSString *)pictureID
          thumbnailURL:(NSString *)thumbnail
        andStandardURL:(NSString *)standard
            atLocation:(NSString *)location
inManagedObjectContext:(NSManagedObjectContext *)context
{
    Picture *picture = nil;
    picture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:context];
    NSString *string = pictureID;
    picture.pictureID = [NSNumber numberWithInteger:[string integerValue]];
    picture.thumbnailLink = thumbnail;
    picture.standardLink = standard;
    picture.location = location;
    picture.imageBinaryData = NULL;
    return picture;
}

@end
