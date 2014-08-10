//
//  ELPhotographerSetup.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 8/10/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELPhotographerSetup.h"
#import "ELDataStore.h"
#import "Photographer+Methods.h"



@interface ELPhotographerSetup()

@property (nonatomic, strong) ELDataStore *dataStore;

@end


@implementation ELPhotographerSetup


- (id)init {
    _dataStore = [ELDataStore sharedELDataStore];
    return self;
}


- (void)createPhotographerList
{
    
    // @petehalvorsen 1809965
    Photographer *peteHalvorsen = [Photographer photographerName:@"Pete Halvorsen" Handle:@"petehalvorsen" idNumber:@"1809965" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    // @mattbg 14464034
    Photographer *mattGee = [Photographer photographerName:@"Matt Gee" Handle:@"mattbg" idNumber:@"14464034" inManagedObjectContext:self.dataStore.managedObjectContext];

    // @zachspassport 14058442
    Photographer *zachGlassman = [Photographer photographerName:@"Zach Glassman" Handle:@"zachspassport" idNumber:@"14058442" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    // @jordanherschel 194220023
    Photographer *jordanHerschel = [Photographer photographerName:@"Jordan Herschel" Handle:@"jordanherschel" idNumber:@"194220023" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    // @chrisburkard 36045182
    Photographer *chrisBurkard = [Photographer photographerName:@"Chris Burkard" Handle:@"chrisburkard" idNumber:@"36045182" inManagedObjectContext:self.dataStore.managedObjectContext];
    
    // @ovunno 2588453
    
    Photographer *oliverVegas = [Photographer photographerName:@"Oliver Vegas" Handle:@"ovunno" idNumber:@"2588453" inManagedObjectContext:self.dataStore.managedObjectContext];

    
    
    
    

}

@end
