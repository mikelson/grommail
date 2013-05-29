//
//  ContactTableViewCell.m
//  
//
//  Created by Peter Mikelsons on 11/14/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//
//

#import "ContactTableViewCell.h"
#import "ContactPictureButton.h"

@implementation ContactTableViewCell
@synthesize pictureView;

- (void)setButtonImage:(UIImage*)image
{
    if (image) {
        //[pictureButton setTitle:nil forState:UIControlStateNormal];
    } else {
        //[pictureButton setTitle:@"add photo" forState:UIControlStateNormal];
        NSBundle* bundle = [NSBundle mainBundle];
        NSString* path = [bundle pathForResource:@"contact-placeholder" ofType:@"jpg"];
        image = [UIImage imageWithContentsOfFile:path];
    }
    pictureView.image = image;
}


@end
