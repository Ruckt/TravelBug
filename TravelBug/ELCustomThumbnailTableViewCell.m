//
//  ELCustomThumbnailTableViewCell.m
//  TravelBug
//
//  Created by Edan Lichtenstein on 7/1/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ELCustomThumbnailTableViewCell.h"

static NSInteger const THUMBNAIL_WIDTH = 150;
static NSInteger const THUMBNAIL_HEIGHT = 150;
static NSInteger const THUMBNAIL_X = 85;
static NSInteger const THUMBNAIL_Y = 10;


@interface ELCustomThumbnailTableViewCell()
@end

@implementation ELCustomThumbnailTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier picture:(Picture *)picture {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //self.locationLabel.text = picture.location;
        
        NSLog(@"Init location: %@", picture.location);
        //self.cellImageView = [self addImageToCell:picture];
        //[self.contentView addSubview:self.cellImageView];
    }
    return self;
}

- (void)configureCellWithPicture:(Picture *)picture {

    self.locationLabel.text = picture.location;
    NSLog(@"Configure location: %@", picture.location);
    
    // Taking apart "thePicture" and fetching the image asyncronously.
//    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);
//    dispatch_async(fetchQ, ^{
//        NSURL *address = [NSURL URLWithString:thePicture.thumbnailLink];
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.cellImageView.image = image;
//        });
//    });
}

- (UIImageView *)addImageToCell:(Picture *)pictureData
{
    // Creating image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(THUMBNAIL_X, THUMBNAIL_Y, THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT)];

    // Taking apart "pictureData" and fetching the image asyncronously.
    dispatch_queue_t fetchQ = dispatch_queue_create("Fetch Image", NULL);

    dispatch_async(fetchQ, ^{
        NSURL *address = [NSURL URLWithString:pictureData.thumbnailLink];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:address]];

        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });

    // Returning the image view
    return imageView;
}

@end
