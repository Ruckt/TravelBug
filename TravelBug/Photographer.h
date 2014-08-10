//
//  Photographer.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/10/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString * handle;
@property (nonatomic, retain) NSString * idNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *picturesTaken;
@end

@interface Photographer (CoreDataGeneratedAccessors)

- (void)addPicturesTakenObject:(Picture *)value;
- (void)removePicturesTakenObject:(Picture *)value;
- (void)addPicturesTaken:(NSSet *)values;
- (void)removePicturesTaken:(NSSet *)values;

@end
