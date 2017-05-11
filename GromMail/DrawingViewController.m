//
//  DrawingViewController.m
//  GromMail
//
//  Created by Peter on 8/28/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

#import <MailCore/MailCore.h>
//#import <MailCore/MCOConstants.h>
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
    [self setContactPictureButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)sendMail
{
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"smtp.gmail.com";
    smtpSession.port = 465;
    smtpSession.username = @"matt@gmail.com";
    smtpSession.password = @"password";
    smtpSession.authType = MCOAuthTypeSASLPlain;
    smtpSession.connectionType = MCOConnectionTypeTLS;
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:@"Matt R"
                                                  mailbox:@"matt@gmail.com"];
    MCOAddress *to = [MCOAddress addressWithDisplayName:nil
                                                mailbox:@"hoa@gmail.com"];
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@"My message"];
    [builder setHTMLBody:@"This is a test message!"];
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation = [smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.user = [AppDelegate getUser];
    
    self.contactPictureButton.image = [UIImage imageWithData:self.contact.picture];
    [self.contactPictureButton setTapTarget:self action:@selector(sendMail)];
    
    // Try to read draft image from model.
    self.drawingView.image = [UIImage imageWithData:self.contact.draftImage];
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setContactPictureButton:nil];
    
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
