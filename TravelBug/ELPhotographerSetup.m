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
    [self.dataStore.photographers addObject:peteHalvorsen];
    
    // @mattbg 14464034
    Photographer *mattGee = [Photographer photographerName:@"Matt Gee" Handle:@"mattbg" idNumber:@"14464034" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:mattGee];

    // @zachspassport 14058442
    Photographer *zachGlassman = [Photographer photographerName:@"Zach Glassman" Handle:@"zachspassport" idNumber:@"14058442" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:zachGlassman];
    
    // @jordanherschel 194220023
    Photographer *jordanHerschel = [Photographer photographerName:@"Jordan Herschel" Handle:@"jordanherschel" idNumber:@"194220023" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:jordanHerschel];
    
    // @chrisburkard 36045182
    Photographer *chrisBurkard = [Photographer photographerName:@"Chris Burkard" Handle:@"chrisburkard" idNumber:@"36045182" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:chrisBurkard];

    // @ovunno 2588453
    Photographer *oliverVegas = [Photographer photographerName:@"Oliver Vegas" Handle:@"ovunno" idNumber:@"2588453" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:oliverVegas];
    
    // @samhorine 765701
    Photographer *samHorine = [Photographer photographerName:@"Sam Horine" Handle:@"samhorine" idNumber:@"765701" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:samHorine];

    // @croyable 4769265 Eelco Roos
    Photographer *eelcoRoos = [Photographer photographerName:@"Eelco Roos" Handle:@"croyable" idNumber:@"4769265" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:eelcoRoos];

    //@wisslaren 214924 Christoffer Collin
    Photographer *christofferCollin = [Photographer photographerName:@"Christoffer Collin" Handle:@"wisslaren" idNumber:@"214924" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:christofferCollin];

    // @peiketron 1275394307 Pei Ketron
    Photographer *peiKetron = [Photographer photographerName:@"Pei Ketron" Handle:@"peiketron" idNumber:@"1275394307" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:peiKetron];
    
    // @fosterhunting 1504627 Foster Huntington
    Photographer *fosterHuntington = [Photographer photographerName:@"Foster Hunting" Handle:@"fosterhunting"  idNumber:@"1504627" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:fosterHuntington];
    
    //@colerise 75 Cole Rise
    Photographer *coleRise = [Photographer photographerName:@"Cole Rise" Handle:@"colerise" idNumber:@"75" inManagedObjectContext:self.dataStore.managedObjectContext];
    [self.dataStore.photographers addObject:coleRise];
}

@end
