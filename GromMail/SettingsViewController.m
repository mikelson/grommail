//
//  SettingsViewController.m
//  GromMail
//
//  Created by Peter on 9/1/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"
#import "Contact.h"
#import "AppDelegate.h"
#import "EditableContactTableViewCell.h"
#import "ContactPictureButton.h"

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
    self.user = [AppDelegate getUser];
    
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
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark IBAction

- (IBAction)updateUserName:(UITextField *)sender {
    self.user.name = sender.text;
}

- (IBAction)updateUserEmail:(UITextField *)sender {
    self.user.emailAddress = sender.text;
}

- (IBAction)addWhitelist {
    // Make index in last row.
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self.user.whiteList count] inSection:0];
    // Add item in last row
    [self tableView:self.whiteListTableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    EditableContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.viewController = self;
    [cell.pictureView setTapTarget:cell action:@selector(changePicture:)];
    // Get the contact from the white list and assign it to the cell.
    NSUInteger index = indexPath.row;
    Contact* contact = [self.user.whiteList objectAtIndex:index];
    cell.contact = contact;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.user.whiteList.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Ordered set accessors are buggy, see http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors
    // Workaround: copy the list, make a change, and overwrite the old list.
    NSMutableOrderedSet* newSet;
    Contact* contact;
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            newSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.user.whiteList];
            [newSet removeObjectAtIndex:indexPath.row];
            [self.user setWhiteList:newSet];
            [self.whiteListTableView reloadData];
            break;
        case UITableViewCellEditingStyleInsert:
            newSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.user.whiteList];
            // Make a new Contact
            contact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact"inManagedObjectContext:[AppDelegate sharedManagedObjectContext]];
            [newSet insertObject:contact atIndex:indexPath.row];
            [self.user setWhiteList:newSet];
            [self.whiteListTableView reloadData];
            break;
        case UITableViewCellEditingStyleNone:
            // do nothing
            break;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // Ordered set accessors are buggy, see http://stackoverflow.com/questions/7385439/exception-thrown-in-nsorderedset-generated-accessors
    // Workaround: copy the list, make a change, and overwrite the old list.
    NSMutableOrderedSet* newSet = [[NSMutableOrderedSet alloc] initWithOrderedSet:self.user.whiteList];
    NSIndexSet* fromIndexSet = [NSIndexSet indexSetWithIndex:fromIndexPath.row];
    [newSet moveObjectsAtIndexes:fromIndexSet toIndex:toIndexPath.row];
    [self.user setWhiteList:newSet];
}
@end
