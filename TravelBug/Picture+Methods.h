//
//  Picture+Methods.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/30/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "Picture.h"

@interface Picture (Methods)

+ (Picture *) pictureID:(NSString *)pictureID
          thumbnailURL:(NSString *)thumbnail
        andStandardURL:(NSString *)standard
inManagedObjectContext:(NSManagedObjectContext *)context;

@end
