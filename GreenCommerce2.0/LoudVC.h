//
//  LoudVC.h
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 4/8/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMosaicLayout.h"
#import "FMMosaicCellView.h"
#import "Chameleon.h"
#import "CNPPopupController.h"





@interface LoudVC : UIViewController{
    UICollectionView *CollectionView;
    NSArray *lines;
    NSMutableArray *moreLines;
    UIImageView *popImageView;
    CNPPopupController *itemPopUp;
    CNPPopupButton *button;
}

@end
