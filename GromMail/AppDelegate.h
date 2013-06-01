//
//  AppDelegate.h
//  GromMail
//
//  Created by Peter on 8/27/12.
//  Copyright (c) 2013 Peter Mikelsons. All rights reserved.
//

@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (NSManagedObjectContext*)sharedManagedObjectContext;

+ (User*)getUser;
@end
