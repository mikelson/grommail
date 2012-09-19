//
//  SettingsViewController.m
//  GromMail
//
//  Created by kaon on 9/1/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"
#import "Contact.h"
#import "AppDelegate.h"
#import "ContactTableViewCell.h"

@interface SettingsViewController ()

@property User* user;

@end

@implementation SettingsViewController
@synthesize userNameTextField = _userName;
@synthesize userEmailTextField = _userEmailAddress;
@synthesize whiteListTableView = _whiteListTableView;

#pragma mark UIViewController

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
    [self setUserNameTextField:nil];
    [self setUserEmailTextField:nil];
    [self setWhiteListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Get the user
    NSManagedObjectContext *context = [AppDelegate sharedManagedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSAssert1(fetchedObjects.count < 2, @"Expected 0 or 1 users, got @d", fetchedObjects.count);
    if (fetchedObjects.count) {
        self.user = [fetchedObjects objectAtIndex:0];
    } else {
        self.user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    }
    
    [self.userNameTextField setText:self.user.name];
    [self.userEmailTextField setText:self.user.emailAddress];
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Save the user
    NSError *error;
    if (![[AppDelegate sharedManagedObjectContext] save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    // Don't need it any more.
    self.user = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IBAction

- (IBAction)updateUserName:(UITextField *)sender {
    self.user.name = sender.text;
}

- (IBAction)updateUserEmail:(UITextField *)sender {
    self.user.emailAddress = sender.text;
}

- (IBAction)addWhitelist {
    Contact* contact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact"
                                                     inManagedObjectContext:[AppDelegate sharedManagedObjectContext]];
    // Does not work, see http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors
    //[self.user addWhiteListObject:contact];
    contact.user = self.user;
    [self.whiteListTableView setNeedsDisplay];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell... get the contact from the white list and assign it to the cell.
    NSUInteger index = indexPath.row;
    Contact* contact = [self.user.whiteList objectAtIndex:index];
    cell.contact = contact;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.user.whiteList.count;
}

@end
