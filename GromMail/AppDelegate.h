//
//  AppDelegate.h
//  GromMail
//
//  Created by kaon on 8/27/12.
//  Copyright (c) 2012 Peter Mikelsons. All rights reserved.
//

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (NSManagedObjectContext*)sharedManagedObjectContext;
@end
