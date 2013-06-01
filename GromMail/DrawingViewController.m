//
//  DrawingViewController.m
//  GromMail
//
//  Created by Peter on 8/28/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingView.h"
#import "Contact.h"
#import "ContactPictureButton.h"

@interface DrawingViewController ()

@end

@implementation DrawingViewController
@synthesize contact;
@synthesize drawingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.drawingView.colorSource = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.drawingView.colorSource = self;
}

- (void)viewDidUnload
{
    [self setDrawingView:nil];
    [self setContactPictureView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.user = [AppDelegate getUser];
    
    self.contactPictureView.image = [UIImage imageWithData:self.contact.picture];
    
    // Try to read draft image from model.
    self.drawingView.image = [UIImage imageWithData:self.contact.draftImage];
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setContactPictureView:nil];
    
    // Save draft image data to model.
    [self.drawingView saveViewToImage];
    NSData* serialization = UIImagePNGRepresentation(self.drawingView.image);
    self.contact.draftImage = serialization;
    
    // Save the user
//    NSError *error;
//    if (![[AppDelegate sharedManagedObjectContext] save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
    // Don't need it any more.
//    self.user = nil;
    self.contact = nil;
}

- (IBAction)setColorToNormalTitle:(UIButton *)sender
{
    _color = [sender titleColorForState:UIControlStateNormal];
}

- (IBAction)eraseDrawing
{
    [drawingView erase];
}
@end
