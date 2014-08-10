//
//  Photographer+Methods.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/9/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "Photographer+Methods.h"

@implementation Photographer (Methods)

+(Photographer *) photographerName:(NSString *)name
                            Handle:(NSString *)handle
                          idNumber:(NSString *)idNumber
            inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    photographer.name = name;
    photographer.handle = handle;
    photographer.idNumber = idNumber;
    photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
    return photographer;
}



@end
