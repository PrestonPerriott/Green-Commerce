//
//  ViewController.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/13/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "StrainsViewController.h"
#import "GreenRequestHandler.h"
#import "Strains.h"
#import "RESideMenu.h"
#import "DeepButton.h"
#import "LoudVC.h"





@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GreenRequestHandlerDelegate>
{
    UICollectionView *CollectionView;
    BOOL dissmissed;
    UIVisualEffectView *EffectView;
    int index2;
}


@end

