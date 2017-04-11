//
//  AppDelegate.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/13/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "AppDelegate.h"
@import GooglePlaces;
@import CoreLocation;
@import GoogleMaps;
#import "RESideMenu.h"








@interface AppDelegate () <RESideMenuDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Wraps View Controller in a Nav Cont so that i can use the navbar
    [GMSPlacesClient provideAPIKey:@"AIzaSyASt7chKW_EroAwB-6-iCzUS-DPzW7KVqE"];
    [GMSServices provideAPIKey:@"AIzaSyD77Gd6FHFH8vgN2CCr1sQ-7qo9XTbhvYI"];
    // directions key AIzaSyAQvkY1phFDSOCWsSCG5V2Oa4J4GiSPBdk
    //distance matrix key AIzaSyAztx23kgL-dQXzgzlWSotHBgwkWFE4WUM
    //**********
    //directions key AIzaSyC3c3nqkPiZRg_A0akZ7S14sEThLpadYP0
  

     
    ViewController *HomeVC = [[ViewController alloc] init];
    UINavigationController *NavCont = [[UINavigationController alloc] initWithRootViewController:HomeVC];
    
    LeftProfileViewController *LeftVC = [[LeftProfileViewController alloc]init];
    RESideMenu *SideMenuVC = [[RESideMenu alloc]initWithContentViewController:NavCont leftMenuViewController:LeftVC rightMenuViewController:nil];
    
    
    
    SideMenuVC.backgroundImage = [UIImage imageNamed:@"WeedYingYang_Copy.jpeg"];
    SideMenuVC.menuPreferredStatusBarStyle = 1;
    SideMenuVC.delegate = self;
    SideMenuVC.contentViewShadowColor = [UIColor blackColor];
    SideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
    SideMenuVC.contentViewShadowOpacity = .6;
    SideMenuVC.contentViewShadowRadius = 12;
    SideMenuVC.contentViewShadowEnabled = YES;
    SideMenuVC.contentViewScaleValue = .25;
    
    _window.rootViewController = SideMenuVC;
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"GreenCommerce2_0"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
