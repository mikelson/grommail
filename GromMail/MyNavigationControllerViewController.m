//
//  MyNavigationControllerViewController.m
//  GromMail
//
//  Created by Peter on 8/27/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "MyNavigationControllerViewController.h"

@interface MyNavigationControllerViewController ()

@end

@implementation MyNavigationControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
