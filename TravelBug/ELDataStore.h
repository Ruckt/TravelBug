//
//  ELDataStore.h
//  TravelBug
//
//  Created by Edan Lichtenstein on 6/29/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Picture.h"

@class Picture;

@interface ELDataStore : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSMutableArray *pictures;


+ (ELDataStore *)sharedELDataStore;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)addPicture:(Picture *)picture;
- (Picture *)getPictureAtIndex:(NSInteger)index;
- (NSInteger)numberofPictures;

@end
