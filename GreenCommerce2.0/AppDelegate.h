//
//  AppDelegate.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/13/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "LeftProfileViewController.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

