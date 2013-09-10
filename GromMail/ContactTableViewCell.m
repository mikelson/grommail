//
//  ContactTableViewCell.m
//  
//
//  Created by Peter Mikelsons on 11/14/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//
//

#import "ContactTableViewCell.h"
#import "ContactPictureButton.h"

@implementation ContactTableViewCell
@synthesize pictureView;

- (void)setButtonImage:(UIImage*)image
{
    pictureView.image = image;
}


@end
