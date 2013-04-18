//
//  DrawingViewController.h
//  GromMail
//
//  Created by kaon on 8/28/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "MyViewController.h"

@class DrawingView;
@class ContactPictureButton;
@class Contact;

@protocol Colored <NSObject>
- (UIColor*)color;
@end

@interface DrawingViewController : MyViewController <Colored>

@property (strong, nonatomic) Contact *contact;

@property (readonly) UIColor* color;

@property (weak, nonatomic) IBOutlet ContactPictureButton *contactPictureView;
@property IBOutlet DrawingView *drawingView;

- (IBAction)setColorToNormalTitle:(UIButton *)sender;

- (IBAction)eraseDrawing;

@end
