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
    _dataStore = [ELDataStore sharedELDataStore];
    return self;
}

- (void)postNotification //post notification method and logic
{
    NSLog(@"Posting fetch notification");
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

- (void)fetchPicturesWithCompletionHandler:(void(^)(NSArray* images, NSError *error))completionHandler {
    NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent/?client_id=%@&count=25",ID_ZACH_GLASSMAN, INSTAGRAM_CLIENT_ID];
    //NSString *instagramEndpoint = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", INSTAGRAM_CLIENT_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:instagramEndpoint parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSArray *pictures = [self pictureObjectsFromResponse:responseDictionary];
        if (completionHandler) {
            completionHandler(pictures,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}


- (void)pictureParsedFromResponse:(NSDictionary *)dictionary
{
    NSDictionary *subDictionary = [dictionary objectForKey:@"data"];
    
    for (NSDictionary *eachPictureInfo in subDictionary) {
        // NSLog(@"Data %@", eachPictureInfo);
        
        NSString *pictureID = [eachPictureInfo objectForKey:@"id"];
        
        NSDictionary *imageInfo = [eachPictureInfo objectForKey:@"images"];
        NSDictionary *thumbnailInfo = [imageInfo objectForKey:@"thumbnail"];
        NSString *thumbnailLink = [thumbnailInfo objectForKey:@"url"];
        
        NSDictionary *standardInfo = [imageInfo objectForKey:@"standard_resolution"];
        NSString *standardLink = [standardInfo objectForKey:@"url"];
        
        //NSLog(@"Location Info %@", locationInfo);
        
        NSString *location = @"Paradise";
        if ([eachPictureInfo objectForKey:@"location"] != [NSNull null]) {
            NSDictionary *locationInfo = [eachPictureInfo objectForKey:@"location"];
            location = [locationInfo objectForKey:@"name"];
            NSLog(@"Location %@", location);
        }

        Picture *picture = [Picture pictureID:pictureID thumbnailURL:thumbnailLink andStandardURL:standardLink atLocation:location inManagedObjectContext:self.dataStore.managedObjectContext];
        [self.dataStore addPicture:picture];
        
        // NSLog(@"Picture Info %@", eachPictureInfo);
        //        NSLog(@"Thumbnail %@", thumbnailLink);
        //        NSLog(@"Standard %@", standardLink);
    }
    
}

// Returns picture objects from a single response.
- (NSArray *)pictureObjectsFromResponse:(NSDictionary *)dictionary
{
    NSDictionary *subDictionary = [dictionary objectForKey:@"data"];
    NSMutableArray *resultPictures = [NSMutableArray new];
    for (NSDictionary *eachPictureInfo in subDictionary) {
        NSString *pictureID = [eachPictureInfo objectForKey:@"id"];
        
        NSDictionary *imageInfo = [eachPictureInfo objectForKey:@"images"];
        NSDictionary *thumbnailInfo = [imageInfo objectForKey:@"thumbnail"];
        NSString *thumbnailLink = [thumbnailInfo objectForKey:@"url"];
        
        NSDictionary *standardInfo = [imageInfo objectForKey:@"standard_resolution"];
        NSString *standardLink = [standardInfo objectForKey:@"url"];
        
        //NSLog(@"Location Info %@", locationInfo);
        
        NSString *location = @"Paradise";
        if ([eachPictureInfo objectForKey:@"location"] != [NSNull null]) {
            NSDictionary *locationInfo = [eachPictureInfo objectForKey:@"location"];
            location = [locationInfo objectForKey:@"name"];
            NSLog(@"Location %@", location);
        }

        Picture *picture = [Picture pictureID:pictureID thumbnailURL:thumbnailLink andStandardURL:standardLink atLocation:location inManagedObjectContext:self.dataStore.managedObjectContext];
        [resultPictures addObject:picture];
    }
    return resultPictures;
}

- (void)downloadImageDataIntoObject:(NSArray *)pictures
{
    for (Picture *onePicture in pictures) {
        NSURL *address = [NSURL URLWithString:onePicture.thumbnailLink];
        
        onePicture.imageBinaryData = [NSData dataWithContentsOfURL:address];
        NSLog(@"DDDDDDDowloaded picture at location: %@", onePicture.location);
    }
}

@end
