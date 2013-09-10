//
//  ContactPictureButton.m
//  GromMail
//
//  Created by Peter Mikelsons on 11/26/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "ContactPictureButton.h"

@implementation ContactPictureButton

// Called when inited by nib
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        // Show all of the image.
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Show all of the image.
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)setImage:(UIImage*)image
{
    if (image) {
        //[pictureButton setTitle:nil forState:UIControlStateNormal];
        super.image = image;
    } else {
        //[pictureButton setTitle:@"add photo" forState:UIControlStateNormal];
        NSBundle* bundle = [NSBundle mainBundle];
        NSString* path = [bundle pathForResource:@"contact-placeholder" ofType:@"jpg"];
        super.image = [UIImage imageWithContentsOfFile:path];
    }
}

- (void)setTapTarget:(id)target action:(SEL)action
{
    // Assume it only has one gesture allowed: the tap. Remove any old tap.
    for (UIGestureRecognizer* gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
    if (target && action) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:tap];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
