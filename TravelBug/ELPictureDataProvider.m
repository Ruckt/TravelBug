//
//  ELPictureDataProvider.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/31/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELPictureDataProvider.h"
#import "ELDataStore.h"
#import "ELConstants.h"
#import "Picture+Methods.h"
#import <AFNetworking.h>

@interface ELPictureDataProvider()

@property (nonatomic, strong) ELDataStore *dataStore;

@end



@implementation ELPictureDataProvider

- (id)init {
    self.dataStore = [ELDataStore sharedELDataStore];
    return self;
}

- (void)postNotification //post notification method and logic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FetchComplete" object:nil];
}


-(void)fetchPictures
{
    
    NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=10",ID_MATT_GEE, INSTAGRAM_CLIENT_ID];
    //NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", INSTAGRAM_CLIENT_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:instagramEndpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        
        [self pictureParsedFromResponse:responseDictionary];
        [self postNotification];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)pictureParsedFromResponse:(NSDictionary *)dictionary
{
    
    NSDictionary *subDictionary = [dictionary objectForKey:@"data"];
    
    for (NSDictionary *eachPictureInfo in subDictionary) {
        
        NSString *picutreID = [eachPictureInfo objectForKey:@"id"];
        
        NSDictionary *imageInfo = [eachPictureInfo objectForKey:@"images"];
        NSDictionary *thumbnailInfo = [imageInfo objectForKey:@"thumbnail"];
        NSString *thumbnailLink = [thumbnailInfo objectForKey:@"url"];
        
        NSDictionary *standardInfo = [imageInfo objectForKey:@"standard_resolution"];
        NSString *standardLink = [standardInfo objectForKey:@"url"];
        
        NSString *location = [eachPictureInfo objectForKey:@"location"];
        NSLog(@"Location %@", location);
        
        Picture *picture = [Picture pictureID:picutreID thumbnailURL:thumbnailLink andStandardURL:standardLink inManagedObjectContext:self.dataStore.managedObjectContext];
        [self.dataStore addPicture:picture];
        
        // NSLog(@"Picture Info %@", eachPictureInfo);
        //        NSLog(@"Thumbnail %@", thumbnailLink);
        //        NSLog(@"Standard %@", standardLink);
    }
}

    
@end
