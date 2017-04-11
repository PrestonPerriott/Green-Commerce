//
//  LumenTableViewCell.m
//  Lumen3.0
//
//  Created by Preston Perriott on 1/24/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"


@interface VLAFloatingViewController : UIViewController
@property (nonatomic, retain, readonly) UIView *viewContent;
@property (nonatomic, retain, readonly) UINavigationItem *navItem;
- (void)exit;
- (void)saveAndExit;
- (instancetype)init;
- (instancetype)initWithIndexPath:(NSIndexPath*)path;
- (instancetype)initWithIndexPath:(NSIndexPath *)path andPhotoArray:(NSArray*)photos;
- (instancetype)initWithIndexPath:(NSIndexPath *)path andPhotoArray:(NSArray *)photos andTurnArray:(NSArray*)turns;



@end
