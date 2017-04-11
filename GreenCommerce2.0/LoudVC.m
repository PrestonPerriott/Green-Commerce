//
//  LoudVC.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 4/8/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

#import "LoudVC.h"

@interface LoudVC () <FMMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CNPPopupControllerDelegate>

@property (strong, nonatomic)UIImageView *cellImageView;

@end

@implementation LoudVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *Home = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"IconHome@2x copy.png"] style:UIBarButtonItemStyleDone target:self action:@selector(PreviousView)];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"99CF26"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"99CF26"];
    self.navigationItem.leftBarButtonItem = Home;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"strainsAgain" ofType:@"csv"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    lines = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSLog(@"INDIVIDUAL IMAGE ADDRESSES : %@", lines);
    moreLines = [[NSMutableArray alloc]initWithArray:lines];
    [moreLines removeObject:@""];
    
    
    NSLog(@" MORE LINES : %@", moreLines);
    self.navigationItem.title = @"E X P L O R E";
    
    FMMosaicLayout *mosaicLayout = [[FMMosaicLayout alloc] init];
    CollectionView.collectionViewLayout = mosaicLayout;
    mosaicLayout.delegate = self;
//UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//CollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero];
    CollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:mosaicLayout];
 //   CollectionView.translatesAutoresizingMaskIntoConstraints = false;
//CollectionView.collectionViewLayout = layout;
    CollectionView.backgroundColor =[UIColor colorWithHexString:@"F4F5D9"];
    [CollectionView setDataSource:self];
    [CollectionView setDelegate:self];
    CollectionView.userInteractionEnabled = TRUE;
    CollectionView.delaysContentTouches = false;
////    CollectionView.canCancelContentTouches = false;
////    [CollectionView setAllowsMultipleSelection:NO];
//    [CollectionView setAllowsSelection:NO];
//    
    
    
    
    [CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
//    [CollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    
    
    [self.view addSubview:CollectionView];
    
//    [CollectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =TRUE;
//    [CollectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = TRUE;
//    [CollectionView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:10].active = TRUE;
//    [CollectionView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = TRUE;
//
    
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    switch (section) {
//    case 0: return 66;
//    case 1: return 123;
//    }
//    return 31;
    return [moreLines count];
}
//
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    popImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,260,300)];
    popImageView.contentMode = UIViewContentModeScaleAspectFill;
    popImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    popImageView.layer.masksToBounds = TRUE;
    popImageView.alpha = .74;
    //_cellImageView.layer.cornerRadius = 5;
    
    NSData *ImageData  = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[moreLines objectAtIndex:indexPath.row]]];
    
    UIImage *bgImage = [UIImage imageWithData:ImageData];
    
    popImageView.image = bgImage;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 350)];
    customView.backgroundColor = [UIColor clearColor];
    customView.layer.cornerRadius = 4;
    [customView addSubview:popImageView];
    
    button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:101.0/255.0 blue:161.0/255.0 alpha:1];
    button.layer.cornerRadius = 10;
    itemPopUp =[[CNPPopupController alloc] initWithContents:@[customView, button]];
    itemPopUp.theme = [CNPPopupTheme defaultTheme];
    itemPopUp.delegate = self;
    button.selectionHandler = ^(CNPPopupButton *button){
        
       // [itemPopUp dismissPopupControllerAnimated:YES];
    };
    
    switch (indexPath.row) {
        case 0:
            [itemPopUp presentPopupControllerAnimated:YES];
            NSLog(@" Index Path :%li", indexPath.row);
            break;
        default:
            
            [itemPopUp presentPopupControllerAnimated:YES];
            NSLog(@" Index Path :%li", indexPath.row);
            break;
    }

   }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed: 116.0/ 255.0 green:182.0/255.0 blue:181/255.0 alpha:.32];
    //cell.layer.cornerRadius = 5;
    //cell.layer.borderWidth = .5;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _cellImageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    _cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    _cellImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _cellImageView.layer.masksToBounds = TRUE;
    _cellImageView.alpha = .74;
    //_cellImageView.layer.cornerRadius = 5;
    
    NSData *ImageData  = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[moreLines objectAtIndex:indexPath.row]]];
    
    UIImage *bgImage = [UIImage imageWithData:ImageData];
    
    _cellImageView.image = bgImage;
    [cell.contentView addSubview:_cellImageView];

    UIGestureRecognizer *cellGesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(cellPressed)];
    [cell addGestureRecognizer:cellGesture];
    cell.userInteractionEnabled = TRUE;

//    NSIndexPath *lastRow = [NSIndexPath indexPathWithIndex:[collectionView numberOfSections]];
//    NSLog(@"Number of Rows in Collection %@", lastRow );

    return cell;
}
#pragma FMMosaicDELE

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
   numberOfColumnsInSection:(NSInteger)section {
    
    return 2; // Or any number of your choosing.
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
}
- (FMMosaicCellSize)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
  mosaicCellSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.item % 12 == 0) ? FMMosaicCellSizeBig : FMMosaicCellSizeSmall;
}
-(void)PreviousView{
    [self.navigationController dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)cellPressed{
    NSLog(@"Cell was pressed at some index");
}

@end
