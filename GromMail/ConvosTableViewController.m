//
//  ConvosTableViewController.m
//  GromMail
//
//  Created by Peter Mikelsons on 11/13/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

#import "ConvosTableViewController.h"
#import "ConvoTableViewCell.h"
#import "User.h"
#import "AppDelegate.h"
#import "DrawingViewController.h"

@interface ConvosTableViewController ()

@property User* user;

@end

@implementation ConvosTableViewController
@synthesize user;

#pragma mark UIViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.user = [AppDelegate getUser];
    
    // Redraw everything in case we're coming back from changing something in settings.
    // Easier than listening for all changes :)
    UITableView* tv = self.tableView;
    [tv reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Save the user?
//    NSError *error;
//    if (![[AppDelegate sharedManagedObjectContext] save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
    // Don't need it any more.
    self.user = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* destination = segue.destinationViewController;
    if ([destination isKindOfClass:[DrawingViewController class]]) {
        DrawingViewController* drawing = (DrawingViewController*)destination;
        
        // Find superview with a contact. Assume sender was a view...
        UIView* view = (UIView*)sender;
        Contact* contact = nil;
        while (view && !contact) {
            if ([view isKindOfClass:[ContactTableViewCell class]]) {
                ContactTableViewCell* contactCell = (ContactTableViewCell*)view;
                contact = contactCell.contact;
            }
            view = view.superview;
        }
        
        
        // Inform destination DrawingViewController whom to show conversation for.
        drawing.contact = contact;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.user.whiteList.count;
        case 1:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsButtonCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section != 0) {
        return nil; // error
    }
    ConvoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConvoCell" forIndexPath:indexPath];
    
    // Configure the cell...
//    cell.viewController = self;
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(changePicture:)];
//    [cell.pictureView addGestureRecognizer:tap];
//    // Get the contact from the white list and assign it to the cell.
    NSUInteger index = indexPath.row;
    Contact* contact = [self.user.whiteList objectAtIndex:index];
    cell.contact = contact;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
