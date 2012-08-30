//
//  DrawingViewController.m
//  GromMail
//
//  Created by kaon on 8/28/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingView.h"
@interface DrawingViewController ()

@end

@implementation DrawingViewController
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
