//
//  StrainsViewController.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/18/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "StrainsViewController.h"
#import "Chameleon.h"


@interface StrainsViewController () <GreenRequestHandlerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *NamesArray;
@property (strong, nonatomic) NSMutableArray *URLArray;
@property (strong, nonatomic) NSMutableArray *ImageArray;
@property (strong, nonatomic) UICollectionView *CollectionView;


@property (strong, nonatomic)UILabel *StrainCellLabel;
@property (assign, nonatomic)BOOL Recursed;

@end

@implementation StrainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    

    [self SetUpStrainsView];
    
    NSLog(@"Names array in View Did load : %@", _NamesArray);
    NSLog(@"Bool in VDL is : %d", _Recursed);
}
- (void)Recursive{
    static int i = 14;
    _Recursed = false;
   // NSLog(@"Recursed should ebe false(0) here : %d", _Recursed);
  
      /*  if (i <= 2 && (_Recursed == false)) {
            
        [[GreenRequestHandler sharedHandler] GetStrainsWithPageNum:i];
        i++;
            [self performSelector:@selector(Recursive) withObject:nil];
    }

    else {
        _Recursed = TRUE;
        NSLog(@"Bool is : %d", _Recursed);
        [_CollectionView reloadData];
        
        
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)SetUpStrainsView{
    
    
    self.navigationItem.title = @"S T R A I N S";
    _StrainsBackground = [UIImage imageNamed:@"StainsBG.jpg"];
    _StrainsImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _StrainsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _StrainsImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _StrainsImageView.layer.masksToBounds = YES;
    _StrainsImageView.image = _StrainsBackground;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_StrainsImageView];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    UIBarButtonItem *Home = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"IconHome@2x copy.png"] style:UIBarButtonItemStyleDone target:self action:@selector(PreviousView)];
    
    self.navigationItem.leftBarButtonItem = Home;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:116.0/ 255.0 green:182.0/255.0 blue:181/255.0 alpha:.52];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    EffectView.frame = self.view.bounds;
    EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    EffectView.alpha = .7;
    [self.view addSubview:EffectView];
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // CollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    _CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _CollectionView.translatesAutoresizingMaskIntoConstraints = false;
    _CollectionView.backgroundView = _StrainsImageView;
    //CollectionView.collectionViewLayout = layout;
    //_CollectionView.backgroundColor = [UIColor colorWithHexString:@"F4F5D9"];

    
    [_CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    
    [self.view addSubview:_CollectionView];
    
    [_CollectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =TRUE;
    [_CollectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = TRUE;
    //[CollectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50].active = TRUE;
    [_CollectionView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:10].active = TRUE;
    [_CollectionView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = TRUE;
    
    
    
    
    NSLog(@"Names array in Set Up View Function : %@", _NamesArray);
    
    
    
}
-(void)PreviousView{
    
   
    [self.navigationController dismissViewControllerAnimated:TRUE completion:nil];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:animated];
    _NamesArray = [[NSMutableArray alloc]init];
    _ImageArray = [[NSMutableArray alloc] init];
    _URLArray = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view.
    [[GreenRequestHandler sharedHandler]setDelegate:self];
    [[GreenRequestHandler sharedHandler] GetStrainsWithPageNum:3];
    //[self Recursive];
    [[GreenRequestHandler sharedHandler]GetStrainsWithPageNum:5];
    [[GreenRequestHandler sharedHandler]GetStrainsWithPageNum:10];
    
    
}
#pragma mark - GreenRequestHandlerdelegate
- (void)requestHandler:(GreenRequestHandler *)request didGetStrains:(NSArray<Strains *> *)strains  {
    for (Strains *strain in strains) {
        NSLog(@"Strain Names : %@", strain.Name);
        NSLog(@"Strain URL : %@", strain.URL);
        
        
    }
}
- (void)requestHandler:(GreenRequestHandler *)request didNotGetStrainsWithError:(NSError *)error{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Green Commerce" message:@"Whoops, we are unable to connect to our netowrk at this time. Please try again later." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)requestHandler:(GreenRequestHandler *)request didGetStrainsWithPageNum:(NSArray<Strains *> *)strains {
    
    NSLog(@"Recursed should also be false(0) here : %d", _Recursed);
    _Recursed = TRUE;
    
    
    for (Strains *strain in strains) {
      //  NSLog(@"Strain Names : %@", strain.Name);
      //  NSLog(@"Strain URL : %@", strain.URL);
      //  NSLog(@"Strain ImageURL : %@", strain.Image);
        

        [_NamesArray addObject:strain.Name];
        [_ImageArray addObject:strain.Image];
        [_URLArray addObject:strain.URL];
        [_CollectionView reloadData];
    }
    
    
    
    _Dic = [[NSDictionary alloc]init];
    _Dic = @{@"Names":_NamesArray, @"Images":_ImageArray, @"URL":_URLArray};

    NSHashTable *Hash = [[NSHashTable alloc]init];
    [Hash addObject:_NamesArray];
    [Hash addObject:_ImageArray];
    [Hash addObject:_URLArray];
    
    if (_Recursed == 1) {
       
}
    //[_CollectionView reloadData];
    //NSLog(@"NamesArray in request handler  :  %@, With count : %lu", _NamesArray, (unsigned long)[_NamesArray count] );
    NSLog(@"THe Dictionary : %@", _Dic);
    [self ReloadTable:_Dic];
    [_CollectionView reloadData];
   // if ([_NamesArray count] >= 85) {
   //     [_CollectionView reloadItemsAtIndexPaths:_NamesArray];
   // }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
       return [_NamesArray count];
    //return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed: 116.0/ 255.0 green:182.0/255.0 blue:181/255.0 alpha:.32];
    cell.layer.cornerRadius = 5;
    
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height * .87)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.borderColor = [UIColor blackColor].CGColor;
    bgView.layer.borderWidth = 1.5;
    bgView.alpha = .9;
    bgView.layer.masksToBounds = TRUE;
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    NSData *ImageData  = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[_ImageArray objectAtIndex:indexPath.row]]];
    
    UIImage *bgImage = [UIImage imageWithData:ImageData];
    
    bgView.image = bgImage;
    //cell.backgroundView = bgView;
    [cell.contentView addSubview:bgView];

    _StrainCellLabel = [[UILabel alloc]init];
    _StrainCellLabel.textColor = [UIColor blackColor];
    _StrainCellLabel.translatesAutoresizingMaskIntoConstraints = false;
    _StrainCellLabel.layer.masksToBounds = YES;
    _StrainCellLabel.text = [NSString stringWithFormat:@"%@",[_NamesArray objectAtIndex:indexPath.row]];
    

   /* if (_Dic) {
        //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * //NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            //});
    
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
    });
    }*/
 
   
    _StrainCellLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    _StrainCellLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _StrainCellLabel.textAlignment = NSTextAlignmentLeft;
    _StrainCellLabel.numberOfLines = 0;
    
    
    
    [cell.contentView addSubview:_StrainCellLabel];
    
   
    [_StrainCellLabel.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-1].active = TRUE;
    [_StrainCellLabel.widthAnchor constraintEqualToAnchor:cell.widthAnchor].active =TRUE;
    [_StrainCellLabel.heightAnchor constraintEqualToConstant:12].active = TRUE;
    [_StrainCellLabel.leftAnchor constraintEqualToAnchor:cell.leftAnchor constant:4].active = true;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.view.frame) * .90, 90);
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.x + 70, 20, 10, 20);
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
#warning present popup UIWebView that goes to link of strain
    
}
-(void)Dissect:(NSArray *)Names withImagesArray:(NSArray *)Images withURLArray:(NSArray *)URLS{

}
-(void)ReloadTable:(NSDictionary*)Dic{
    
    [_CollectionView reloadData];
}
@end
