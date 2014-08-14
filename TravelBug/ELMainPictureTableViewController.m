//
//  ELMainPictureTableViewController
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELMainPictureTableViewController.h"
#import "ELCustomThumbnailTableViewCell.h"
#import "ELPictureViewController.h"
#import "ELDataStore.h"
#import "ELPictureDataProvider.h"
#import "LCZoomTransition.h"

static NSString *CellIdentifier = @"Cell";

@interface ELMainPictureTableViewController ()

@property (strong, nonatomic) ELDataStore *dataStore;
@property (strong, nonatomic) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) LCZoomTransition *zoomTransition;
@property (strong, nonatomic) NSArray *pictures;


@end

@implementation ELMainPictureTableViewController


- (void) viewDidLoad
{
    self.dataStore = [ELDataStore sharedELDataStore];
    ELPictureDataProvider *dataProvider = [ELPictureDataProvider new];
    self.imageOperationQueue = [[NSOperationQueue alloc] init];
    [self.imageOperationQueue setMaxConcurrentOperationCount:10];
    self.zoomTransition = [[LCZoomTransition alloc] initWithNavigationController:self.navigationController];

    
    [dataProvider fetchPicturesWithCompletionHandler:^(NSArray *images, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            // Instead of loading images from internet, if the request has errors, we can load it from core data:

            NSManagedObjectContext *context = self.dataStore.managedObjectContext;
            // Load from core data:
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Picture" inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            // Specify how the fetched objects should be sorted
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pictureID" ascending:YES];
            [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

            NSError *error = nil;
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects == nil) {
                NSLog(@"Error: %@", error);
            }
            self.pictures = fetchedObjects;
            NSLog(@"Fetched Objects: %ld", [fetchedObjects count]);
            [self.tableView reloadData];
            
            return;
        }
        self.pictures = images;
        [self.tableView reloadData];
        //[dataProvider downloadImageDataIntoObject:self.pictures];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - NSNotification Center

- (void)receiveEvent:(NSNotification *)notification {
    NSLog(@"Received Picture Data Data Data");
    
    [self.tableView reloadData];
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count: %ld", [self.pictures count]);
    return [self.pictures count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ELCustomThumbnailTableViewCell *cell = (ELCustomThumbnailTableViewCell *) [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Picture *picture = [self.pictures objectAtIndex:indexPath.row];
    
    
    //NSLog(@"thumbnail URL: %@", picture.thumbnailLink);
    
    if (!cell) {
        // This is only being called when you are instantiating the cell for the first time.
        cell = [[ELCustomThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier picture:picture];
        NSLog(@" If location: %@", picture.location);
    }

    // We are re-using a cell. We are not re-instantiating it. We are just going to change its picture.
    [cell configureCellWithPicture:picture];
    
    cell.cellImageView.image = nil;
    
    if (picture.imageBinaryData == NULL) {
        
        [self.imageOperationQueue addOperationWithBlock:^{
            
            NSURL *address = [NSURL URLWithString:picture.thumbnailLink];
            picture.imageBinaryData = [NSData dataWithContentsOfURL:address];
            UIImage *image = [UIImage imageWithData:picture.imageBinaryData];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //ELCustomThumbnailTableViewCell *updateCell = (ELCustomThumbnailTableViewCell *) [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell) { // if nil then cell is not visible hence no need to update
                    cell.cellImageView.image = image;
                }
            }];
        }];
    }
    else {
        cell.cellImageView.image = [UIImage imageWithData:picture.imageBinaryData];
    }
    
    NSLog(@"Return location: %@", picture.location);
    
    return cell;
}



#pragma mark - Table view delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"pictureSelected"])
    {
        
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        Picture *picture = [self.pictures objectAtIndex:ip.row];

        ELPictureViewController *pictureViewController = (ELPictureViewController *)segue.destinationViewController;
        pictureViewController.picture = picture;
        
        // pass the custom transition to the destination controller
        // so it can use it when setting up its gesture recognizers
        [[segue destinationViewController] setGestureTarget:self.zoomTransition];
        
        // the transition controller needs to know the view (cell)
        // that originated the segue in order to be able to "split"
        // the table view correctly
        self.zoomTransition.sourceView = [self.tableView cellForRowAtIndexPath:ip];
    }
    
}





@end
