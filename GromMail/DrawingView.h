//
//  DrawingView.h
//  GromMail
//
//  Created by kaon on 8/28/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingViewController.h"

@interface DrawingView : UIView

- (void)saveViewToImage;
- (void)erase;

@property (strong, nonatomic) UIImage* image;

// To dealloc DrawingView when it gets hidden, using ARC,
// "make the parent-to-child relationship strong and the child-to-parent relationship weak".
// This loses us iOS 4 right here, but so what? 20% and dropping, and supposedly non-upgraders don't buy...
@property (weak) id<Colored> colorSource;
@end
