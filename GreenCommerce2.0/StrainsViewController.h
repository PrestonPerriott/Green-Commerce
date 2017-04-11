//
//  StrainsViewController.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/18/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "GreenRequestHandler.h"
#import "Strains.h"


@interface StrainsViewController : UIViewController {
    NSMutableArray *removedIndexes;
}
@property (strong, nonatomic) UIImage *StrainsBackground;
@property (strong, nonatomic) UIImageView *StrainsImageView;

@property (strong, nonatomic)NSDictionary *Dic;

@end
