//
//  ELThumbnailListViewController.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELThumbnailListViewController.h"
#import "ELCustomThumbnailTableViewCell.h"
#import "ELPictureViewController.h"
#import "ELDataStore.h"

static NSInteger const CELL_HEIGHT = 170;

@interface ELThumbnailListViewController ()

@property (strong, nonatomic) ELDataStore *dataStore;
@property (strong, nonatomic) NSArray *pictures;

@end

@implementation ELThumbnailListViewController


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        self.dataStore = [ELDataStore sharedELDataStore];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.pictures = [self.dataStore pictures];
                
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pictures count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    ELCustomThumbnailTableViewCell *cell = (ELCustomThumbnailTableViewCell *) [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Picture *picture = [self.pictures objectAtIndex:indexPath.row];
    //NSLog(@"thumbnail URL: %@", picture.thumbnailLink);
    
    if (!cell) {
        // This is only being called when you are instantiating the cell for the first time.
        cell = [[ELCustomThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier picture:picture];
    }
    else {
        // We are re-using a cell. We are not re-instantiating it. We are just going to change its picture.
        [cell configureCellWithPicture:picture];
    }

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ELPictureViewController *pictureViewController = [[ELPictureViewController alloc] initWithPicture:[self.dataStore getPictureAtIndex:indexPath.row]];
    NSLog(@"index Path %ld", (long)indexPath.row);
    [self.navigationController pushViewController:pictureViewController animated:YES];
}

@end
