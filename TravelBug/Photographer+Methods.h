//
//  Photographer+Methods.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/9/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Methods)

+(Photographer *) photographerName:(NSString *)name
                            Handle:(NSString *)handle
                          idNumber:(NSString *)idNumber
            inManagedObjectContext:(NSManagedObjectContext *)context;

@end
