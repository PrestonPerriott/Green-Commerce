//
//  ViewController.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 10/13/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;
#import "AFNetworking.h"
#import "LocationViewController.h"
#import "TOMSMorphingLabel.h"
#import "NSString+HTMLParse.h"
#import "iCarousel.h"
#import "DeepButton.h"
#import "Chameleon.h"











@interface ViewController () <NSXMLParserDelegate, iCarouselDataSource, iCarouselDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) UIImage *BGImage;
@property (strong, nonatomic) UIImageView *BGImageView;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *WhyLogin;
@property (strong, nonatomic) UILabel *Feild1;
@property (strong, nonatomic) UILabel *Feild2;
@property (strong, nonatomic) NSData *data;

@property (strong, nonatomic) NSMutableArray *DataArray;
@property (strong, nonatomic) NSMutableArray *GenData;
@property (strong, nonatomic) NSDictionary *GenData2;
@property (strong, nonatomic) NSMutableArray *Strains;

@property (strong, nonatomic) NSMutableArray *Images;
@property (strong, nonatomic) NSMutableArray *Names;
@property (strong, nonatomic)
NSMutableArray *cellNames;

@property (strong, nonatomic)
NSMutableArray *cellImages;

@property(strong, nonatomic)
UILabel* NameLabel;

@property (strong, nonatomic)
UIImageView *cellImageView;

@property (strong, nonatomic)
TOMSMorphingLabel *TitleLabel;
@property (strong, nonatomic)
UIView *NameLabelView;



@property (strong, nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableArray *feeds;
@property (strong, nonatomic) NSMutableDictionary *item;
@property (strong, nonatomic) NSMutableString *feedTitle;
@property (strong, nonatomic) NSMutableString *link;
@property (strong, nonatomic) NSMutableString *feedText;
@property (strong, nonatomic) NSString *element;
@property (strong, nonatomic) iCarousel *Carousel;


@property (strong, nonatomic) UIView *newsview;

@property (retain, nonatomic)NSMutableArray *StrainNames;
@property (assign, nonatomic)BOOL DidGetNames;

@property (strong, nonatomic)UITextView *ArticleText;

@property (strong, nonatomic)NSTimer *typingTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [[GreenRequestHandler sharedHandler] setDelegate:self];
   // [[GreenRequestHandler sharedHandler] getStrains];
    
    _cellNames = [[NSMutableArray alloc]initWithObjects:@"Parks",@"Strains",@"Dispensaries",@"Cool Ideas",@"Beautifully Loud", nil];
    [self SetUpView];
    //[self RequestData];
    [self UpdateTitleLabel];
    NSLog(@"Starting timer : ");
    
    _DidGetNames = false;
    
    [self reloadNewsFeed];
    
    //Feeds is an array and item is a dictionary inside feeds...
    
    NSLog(@"Feeds : %@", _feeds );
    
    
    //we itereate items into feeds, so we have to access all the articles through feeds
    NSLog(@"Feed 1 title : %@", [[_feeds objectAtIndex:0] valueForKey:@"title" ]);
    
    
    //Item is just the last content,link,title tuple
    //NSLog(@"Item : %@", _item);
    //NSLog(@"Item content :%@", [_item objectForKey:@"content:encoded"]);
    
    //NSLog(@"Item title :%@", [_item objectForKey:@"title"]);
    
    if (_DidGetNames) {
        NSLog(@"reloaded");
        
        [_Carousel reloadData];
    }
    
    }


- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }
-(void)SetUpView{
    
    _NameLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    _TitleLabel = [[TOMSMorphingLabel alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    _TitleLabel.textColor = [UIColor colorWithRed:255.0/ 255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.52];
    _TitleLabel.layer.masksToBounds = YES;
    _TitleLabel.text = @"";
    _TitleLabel.font = [UIFont fontWithName:@"Georgia" size:22];
    _TitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _TitleLabel.textAlignment = NSTextAlignmentCenter;
    _TitleLabel.numberOfLines = 1;
    //[_NameLabelView addSubview:_TitleLabel];
    //self.navigationItem.titleView = _NameLabelView;
    
    self.navigationItem.title = @"G R E E N  C O M M E R C E";
    
   // [self.navigationController setTitle:@"Green Comemrce"];
     
    
    // Create the location manager if this object does not
    // already have one.
    
    
    
    

    _BGImage = [UIImage imageNamed:@"GradientBG.jpg"];
    _BGImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _BGImageView.contentMode = UIViewContentModeScaleAspectFill;
    _BGImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _BGImageView.layer.masksToBounds = TRUE;
    _BGImageView.image = _BGImage;
    //self.view.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:_BGImageView];
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
   // CollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    CollectionView.translatesAutoresizingMaskIntoConstraints = false;
    
    //CollectionView.collectionViewLayout = layout;
    
    [CollectionView setDataSource:self];
    [CollectionView setDelegate:self];
    
    [CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [CollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [_BGImageView addSubview:EffectView];
   // CollectionView.backgroundView = _BGImageView;
    CollectionView.backgroundColor =[UIColor colorWithHexString:@"F4F5D9"];
    
    
    [self.view addSubview:CollectionView];
    
    [CollectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =TRUE;
    [CollectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = TRUE;
    //[CollectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50].active = TRUE;
    [CollectionView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:10].active = TRUE;
    [CollectionView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = TRUE;
    
    
    
 
    
    
    
    _locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    _locationManager.delegate = self; // we set the delegate of locationManager to self.
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
     [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    
    /*self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
   */
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"99CF26"];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"99CF26"];
    
    
    
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IconProfile@2x copy.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Left)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:255.0/ 255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.52];
    
    _ArticleText = [[UITextView alloc]init];
    _ArticleText.translatesAutoresizingMaskIntoConstraints = false;
    _ArticleText.layer.cornerRadius = 5;
    _ArticleText.backgroundColor = [UIColor colorWithHexString:@"99CF26"];
    _ArticleText.backgroundColor = [UIColor colorWithComplementaryFlatColorOf:[UIColor colorWithHexString:@"F4F5D9"]];
    //_ArticleText.backgroundColor = [UIColor colorWithComplementaryFlatColorOf:[UIColor colorWithAverageColorFromImage:_BGImage]];
    
    _ArticleText.alpha = 0.0f;
    _ArticleText.font = [_ArticleText.font fontWithSize:26];
    _ArticleText.textColor = [UIColor blackColor];
    _ArticleText.scrollEnabled = TRUE;
    _ArticleText.userInteractionEnabled = TRUE;
    _ArticleText.layer.shadowOffset = CGSizeMake(-15, 20);
    _ArticleText.layer.shadowRadius = 5;
    _ArticleText.layer.shadowOpacity = 3;

    
    [CollectionView addSubview:_ArticleText];
    [_ArticleText.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = TRUE;
    [_ArticleText.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-50].active = TRUE;
    [_ArticleText.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-70].active= TRUE;
    [_ArticleText.heightAnchor constraintEqualToConstant:300].active = TRUE;
    
}
- (void)RequestData{

    //Base URL to connect to the Cannabis API
    NSString *url = @"https://www.cannabisreports.com/api/v1.0/strains?sort=name&page=";
    //Generates a random number between 100, makes it a string val
    NSString *randNum = [@(arc4random()%100) stringValue];
    //Append base url with the random number,
    //At runtime we are given a random page to take data from
    NSString *fullString = [url stringByAppendingString:randNum];
    
    //Asks for info(JSON data) from fullstring
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:fullString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        //Checks if JSOn is array or dictionary
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            _GenData = [[NSMutableArray alloc] init];
            _GenData = responseObject;
            NSLog(@"Array : %@", _GenData);
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
         
            _GenData2 = [[NSDictionary alloc] init];
            _GenData2 = responseObject;
            NSLog(@"Dictionary : %@", _GenData2);
            
            //Strone specific "data" information from JSON in _DataArray
            _DataArray = [_GenData2 objectForKey:@"data"];
            
            //Send _DataArray to function to be parsed/used
            [self SetUpDictionary:_DataArray];
            
        }
        
    }failure:^(NSURLSessionTask *task, NSError *error){
        NSLog(@"The error is : %@", error);}];}

//Made a function that will be called inside of the GET block to handle the information recieved/Make a dictionary out of the array its passed
-(void)SetUpDictionary:(NSMutableArray *)results{
    
    //Reassign _dataarray to equal
    _DataArray = results;
    _Names = [[NSMutableArray alloc] init];
    _Images = [[NSMutableArray alloc] init];
    
    //for loop to populate a Dictionary with the exact vals we want
    for (int i = 0; i < [_DataArray count]; ++i) {
        
        
        NSDictionary *SN2  = [_DataArray objectAtIndex:i];
        
        NSString *key = [SN2 objectForKey:@"name"];
        [_Names addObject:key];
        
        NSString *key2 = [SN2 objectForKey:@"image"];
        [_Images addObject:key2];
        
    }
    
    NSDictionary *Dict = [NSDictionary dictionaryWithObjects:_Names forKeys:_Images];
    NSLog(@"Dict : %@", Dict);
    //Now we need to pass the Dictionary to another Function to update the Background when necessary
    [self UpdateBackground:Dict];
    
}
-(void)UpdateTitleLabel{
    static int i = 0;
    NSArray *titleArray = [[NSArray alloc]initWithObjects:@"Welcome to", @"Green Commerce",@"Where our motto is :",@"The Freedom of Smoke" , nil];
    if (i < [titleArray count] ) {
        [UIView transitionWithView:self.view duration:3.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _TitleLabel.text = titleArray[i];
            i++;
            } completion:nil];
        
        [self performSelector:@selector(UpdateTitleLabel) withObject:nil afterDelay:3.0];
        
    }else{
        i = 0;
       [self performSelector:@selector(UpdateTitleLabel) withObject:nil afterDelay:3.0];
    }
    
}
-(void)UpdateBackground:(NSDictionary *)dict{
    
    
    static int i = 0; //static so it saves its changed val
    if (i < [dict count]) {
        //Changes the URL type to a string to be stored in data
        _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[dict allKeys]objectAtIndex:i]]];
        _BGImage = [[UIImage alloc] initWithData:_data];
        
        [UIView transitionWithView:_BGImageView duration:3.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _BGImageView.image = _BGImage;
        }completion:nil];
        [self performSelector:@selector(UpdateBackground:) withObject:dict afterDelay:2.0];
        i++;
    }else{
        i = 0;
       [self performSelector:@selector(UpdateBackground:) withObject:dict afterDelay:2.0];
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_cellNames count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed: 116.0/ 255.0 green:182.0/255.0 blue:181/255.0 alpha:.32];
    cell.layer.cornerRadius = 5;
    
   // _cellNames = [[NSMutableArray alloc]initWithObjects:@"Parks",@"Strains",@"Dispensaries",@"Cool Ideas",@"Smoking Info", nil];
    
    _cellImages = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"parks.jpg"],[UIImage imageNamed:@"Strains.jpg"],[UIImage imageNamed:@"Dispensaries.jpg"],[UIImage imageNamed:@"CoolIdeas.jpg"],[UIImage imageNamed:@"SmokingInfo.jpg"], nil];
    
    _cellImageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    _cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    _cellImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _cellImageView.layer.masksToBounds = TRUE;
    _cellImageView.alpha = .34;
    _cellImageView.layer.cornerRadius = 5;
    
    
   //_cellImageView.image = [UIImage imageNamed:[_cellImages objectAtIndex:indexPath.row]];
    _cellImageView.image = [_cellImages objectAtIndex:indexPath.row];
    
    //_cellImageView.image =[UIImage imageNamed:@"parks.jpg"];
    
    //cell.backgroundView = _cellImageView;
    
    
    [cell.contentView addSubview:_cellImageView];

    
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.textColor = [UIColor blackColor];
    _NameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _NameLabel.layer.masksToBounds = YES;
    _NameLabel.text = [_cellNames objectAtIndex:indexPath.row];

    _NameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _NameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    _NameLabel.numberOfLines = 1;
    
    
    
    [cell.contentView addSubview:_NameLabel];
    
   //[_NameLabel.centerXAnchor constraintEqualToAnchor:cell.centerXAnchor].active = TRUE;
    [_NameLabel.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor constant:-1].active = TRUE;
    [_NameLabel.widthAnchor constraintEqualToConstant:230].active =TRUE;
    [_NameLabel.heightAnchor constraintEqualToConstant:26].active = TRUE;
    [_NameLabel.leftAnchor constraintEqualToAnchor:cell.leftAnchor constant:4].active = true;
    

    NSIndexPath *lastRow = [NSIndexPath indexPathWithIndex:[collectionView numberOfSections ]];
    NSLog(@"Number of Rows in Collection %@", lastRow );
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width -50, 60);
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.x + 20, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    _locationManager.delegate = self; // we set the delegate of locationManager to self.
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    // [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];  //requesting location updates
    NSLog(@"Location Permissions granted");
    NSLog(@"Location is : %@",[_locationManager location] );
    NSLog(@"Latitude: %f, Longitude: %f, Altitude: %f, Speed: %f", _locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude, _locationManager.location.altitude, _locationManager.location.speed);
    
    
    LocationViewController *LVC = [[LocationViewController alloc] init];
    UINavigationController *LVCNavCont = [[UINavigationController alloc] initWithRootViewController:LVC];
    
    LVC.locationManager = _locationManager;
    
    //[self presentViewController:LVCNavCont animated:YES completion:nil];
    
    StrainsViewController *StrainView = [[StrainsViewController alloc] init];
    UINavigationController *StrainsNVC = [[UINavigationController alloc ]initWithRootViewController:StrainView];
    
    LoudVC *LoudController = [[LoudVC alloc]init];
    UINavigationController *LoudNav = [[UINavigationController alloc]initWithRootViewController:LoudController];
    
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"Locations Info Pressed");
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.center = self.view.center;
            [self.view addSubview:spinner];
            [spinner startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // This is the operation that blocks the main thread, so we execute it in a background thread
                [self presentViewController:LVCNavCont animated:YES completion:nil];
                
                // UIKit calls need to be made on the main thread, so re-dispatch there
                dispatch_async(dispatch_get_main_queue(), ^{
                    [spinner stopAnimating];
                });
            });
            
        }
            break;
        case 1:
        {
            NSLog(@"Strains Info Pressed");
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.center = self.view.center;
            [self.view addSubview:spinner];
            [spinner startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // This is the operation that blocks the main thread, so we execute it in a background thread
                [self presentViewController:StrainsNVC animated:YES completion:nil];
                
                // UIKit calls need to be made on the main thread, so re-dispatch there
                dispatch_async(dispatch_get_main_queue(), ^{
                    [spinner stopAnimating];
                });
            });
            
        }
            break;
        case 2:
            NSLog(@"Dispensaries Pressed");
            break;
        case 3:
            NSLog(@"Cool Ideas Pressed");
            break;
            case 4:
        {
            NSLog(@"Smoking Info Pressed");
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.center = self.view.center;
            [self.view addSubview:spinner];
            [spinner startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // This is the operation that blocks the main thread, so we execute it in a background thread
               [self presentViewController:LoudNav animated:YES completion:nil];
                
                // UIKit calls need to be made on the main thread, so re-dispatch there
                dispatch_async(dispatch_get_main_queue(), ^{
                    [spinner stopAnimating];
                });
            });
            
        }
        default:
            break;
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableview==nil) {
            
            reusableview =[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 380, 44)];
        }
        
        _newsview = [[UIView alloc]init];
        _newsview.backgroundColor = [[UIColor colorWithHexString:@"99CF26"]colorWithAlphaComponent:.56];
        _newsview.translatesAutoresizingMaskIntoConstraints   = false;
        _newsview.layer.cornerRadius = 5;
        
        [reusableview addSubview:_newsview];
        
        [_newsview.centerYAnchor constraintEqualToAnchor:reusableview.centerYAnchor].active = TRUE;
        [_newsview.centerXAnchor constraintEqualToAnchor:reusableview.centerXAnchor].active = TRUE;
        [_newsview.widthAnchor constraintEqualToAnchor:reusableview.widthAnchor constant:-30].active = TRUE;
        [_newsview.heightAnchor constraintEqualToAnchor:reusableview.heightAnchor constant:-20].active =TRUE;
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100, 50, 320, 44)];
        
         label.text= [NSString stringWithFormat:@"News Stuff"];
    //  [reusableview addSubview:label];
        
        _Carousel = [[iCarousel alloc]init];
        _Carousel.translatesAutoresizingMaskIntoConstraints = false;
        _Carousel.alpha = .77;
        _Carousel.layer.cornerRadius = 4;
        _Carousel.type = iCarouselTypeLinear;
        _Carousel.delegate = self;
        _Carousel.dataSource = self;
        
        
        [_newsview addSubview:_Carousel];
        
        [_Carousel.centerXAnchor constraintEqualToAnchor:_newsview.centerXAnchor].active = TRUE;
        [_Carousel.centerYAnchor constraintEqualToAnchor:_newsview.centerYAnchor].active = TRUE;
        [_Carousel.widthAnchor constraintEqualToAnchor:_newsview.widthAnchor].active = TRUE;
        [_Carousel.heightAnchor constraintEqualToAnchor:_newsview.heightAnchor constant:10].active = TRUE;
        
        
        
               return reusableview;
    }
    return nil;
    
      }
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize headerSize = CGSizeMake(CGRectGetWidth(self.view.frame), 220);
    return headerSize;
}
-(void)Left{
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}
-(void)reloadNewsFeed{
    
    _feeds = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"https://www.cannabisindustryjournal.com/feed/"];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_parser setDelegate:self];
    [_parser setShouldResolveExternalEntities:NO];
    [_parser parse];
    
    NSLog(@"XML : %@", _parser );
    
    
    
    
    
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    //handles the current string element
    _element = elementName;
    
    if ([_element isEqualToString:@"item"]) {
        _item = [[NSMutableDictionary alloc]init];
        _feedTitle = [[NSMutableString alloc] init];
        _link = [[NSMutableString alloc]init];
        _feedText = [[NSMutableString alloc]init];
    }
    
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([_element isEqualToString:@"title"]) {
        
        [_feedTitle appendString:string];
        
    }else if ([_element isEqualToString:@"link"]){
        [_link appendString:string];
        
    }else if ([_element isEqualToString:@"content:encoded"]){
        string = [string stringByStrippingHTML];
        [_feedText appendString:string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"item"]) {
        [_item setObject:_feedTitle forKey:@"title"];
        [_item setObject:_link forKey:@"link"];
        [_item setObject:_feedText forKey:@"content:encoded"];
        
        [_feeds addObject:_item];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
   /* [super viewDidAppear:animated];
    [[GreenRequestHandler sharedHandler] setDelegate:self];
    [[GreenRequestHandler sharedHandler] getStrains]; */
}
- (void)requestHandler:(GreenRequestHandler *)request didGetStrains:(NSArray<Strains *> *)strains  {
    
    _StrainNames = [[NSMutableArray alloc]init];
    for (Strains *strain in strains) {
        
        [_StrainNames addObject:strain.Name];
        
        
    }
    _DidGetNames = TRUE;
}
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
  //  return [_feeds count];
    NSLog(@"Feeds title size : %lu", (unsigned long)[[_feeds valueForKey:@"title"]count]);
    
       return [[_feeds valueForKey:@"title"]count];

}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UILabel *label = nil;
    UITextView *textView = nil;
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:_newsview.bounds];
        view.userInteractionEnabled = TRUE;
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [label.font fontWithSize:24];
        label.textColor = [UIColor blackColor];
        label.tag = 1;
       [view addSubview:label];
        textView = [[UITextView alloc]initWithFrame:view.bounds];
        textView.layer.cornerRadius = 5;
        textView.font = [textView.font fontWithSize:12];
        textView.scrollEnabled = TRUE;
        textView.userInteractionEnabled = TRUE;
     //   [view addSubview:textView];
       
        
        
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    //label.text = _StrainNames[index];
    label.text = [_feeds[index] valueForKey:@"title"];
    textView.text = [_feeds[index]valueForKey:@"content:encoded"];
    
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(null)];
    [Tap setNumberOfTapsRequired:1];
  //  [label addGestureRecognizer:Tap];
    [label setUserInteractionEnabled:YES];
    
    return view;
}
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    
    switch (index) {
        case 0:
        {
            dissmissed = false;
            NSLog(@"Pop");
            _ArticleText.text = @"";
            [_typingTimer invalidate];
            _typingTimer = 0;
          //  _ArticleText.text = [_feeds[index]valueForKey:@"content:encoded"];
            [UIView animateWithDuration:1.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                [_ArticleText setAlpha:1.0f];
                _ArticleText.layer.cornerRadius = 10;
               // [_ArticleText setTransform:CGAffineTransformMakeRotation((CGFloat)3.14)];
                
                [_ArticleText setTransform:CGAffineTransformMakeScale(.4, .4)];
                [_ArticleText setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                
                
            } completion:^(BOOL finished) {
                
                _typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.030
                                                                        target:self
                                                              selector:@selector(typeALetter: atIndex:)
                                                                      userInfo:nil
                                                                       repeats:YES];
                
                
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                EffectView.frame = self.view.bounds;
                EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                EffectView.alpha = .7;
                 [CollectionView insertSubview:EffectView belowSubview:_ArticleText];
                
                UIButton *transparencyButton = [[UIButton alloc] initWithFrame:self.view.bounds];
                transparencyButton.backgroundColor = [UIColor clearColor];
                [CollectionView insertSubview:transparencyButton belowSubview:_ArticleText];
                [_ArticleText sendSubviewToBack:transparencyButton];
                [transparencyButton addTarget:self action:@selector(dismissHelper:) forControlEvents:UIControlEventTouchUpInside];
                
            }];
        }
                break;
            case 1:
        {
            NSLog(@"Pop");
            _ArticleText.text = @"";
            [_typingTimer invalidate];
            _typingTimer = 0;
            dissmissed = false;
            [UIView animateWithDuration:1.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                [_ArticleText setAlpha:1.0f];
                _ArticleText.layer.cornerRadius = 10;
                [_ArticleText setTransform:CGAffineTransformMakeScale(.4, .4)];
                [_ArticleText setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                
                
            } completion:^(BOOL finished) {
                _typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.030
                                                                target:self
                                                              selector:@selector(typeALetter: atIndex:)
                                                              userInfo:nil
                                                               repeats:YES];
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                EffectView.frame = self.view.bounds;
                EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                EffectView.alpha = .7;
                [CollectionView insertSubview:EffectView belowSubview:_ArticleText];
                
                UIButton *transparencyButton = [[UIButton alloc] initWithFrame:self.view.bounds];
                transparencyButton.backgroundColor = [UIColor clearColor];
                [CollectionView insertSubview:transparencyButton belowSubview:_ArticleText];                [transparencyButton addTarget:self action:@selector(dismissHelper:) forControlEvents:UIControlEventTouchUpInside];
                
            }];
        }
            break;
                default:
            dissmissed = false;
            _ArticleText.text = @"";
            [_typingTimer invalidate];
            _typingTimer = 0;
            NSLog(@"Pop");
            
            [UIView animateWithDuration:1.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
                [_ArticleText setAlpha:1.0f];
                _ArticleText.layer.cornerRadius = 10;
                // [_ArticleText setTransform:CGAffineTransformMakeRotation((CGFloat)3.14)];
                [_ArticleText setTransform:CGAffineTransformMakeScale(.4, .4)];
                [_ArticleText setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                
            } completion:^(BOOL finished) {
                _typingTimer = [NSTimer scheduledTimerWithTimeInterval:0.030
                                                                target:self
                                                              selector:@selector(typeALetter: atIndex:)
                                                              userInfo:nil
                                                               repeats:YES];
                
                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                EffectView.frame = self.view.bounds;
                EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                EffectView.alpha = .7;
                [CollectionView insertSubview:EffectView belowSubview:_ArticleText];
                
                UIButton *transparencyButton = [[UIButton alloc] initWithFrame:self.view.bounds];
                transparencyButton.backgroundColor = [UIColor clearColor];
                [CollectionView insertSubview:transparencyButton belowSubview:_ArticleText];
                [transparencyButton addTarget:self action:@selector(dismissHelper:) forControlEvents:UIControlEventTouchUpInside];
            }];
    
            break;
    }
    
    
}
- (void)dismissHelper:(UIButton *)sender
{
    index2 = 0;
    
    [UIView animateWithDuration:0.8f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _ArticleText.alpha = 0;
        [_typingTimer invalidate];
    
        _typingTimer = nil;
        _ArticleText.userInteractionEnabled = NO;
        [EffectView removeFromSuperview];
        
        
        //[_ArticleText setText:@""];
        dissmissed = true;
     /*   [_ArticleText setTransform:CGAffineTransformMakeScale(.4, .4)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.2, .2)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.150, .150)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.100, .100)]; */
        
    } completion:^(BOOL finished) {
        
 /*       [_ArticleText setTransform:CGAffineTransformMakeScale(.1, .1)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.0500, .0500)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.0250, .0250)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.0100, .0100)];
        [_ArticleText setTransform:CGAffineTransformMakeScale(.0050, .0050)];
        
*/
        }];

    sender.hidden = YES;
    // or [sender removeFromSuperview]
}
- (void)typeALetter:(id)sender atIndex:(NSUInteger)index {
    //First index points to the current open item in carousel
    //That way we have a idrect specify for which article we want
    index = [_Carousel currentItemIndex];
        
        //index2 is just a static int that interates through the loop for the "typing"
    
    if (index2 < [[_feeds[index]valueForKey:@"content:encoded"] length]) {
        _ArticleText.text = [_ArticleText.text stringByAppendingFormat:@"%@", [[_feeds[index]valueForKey:@"content:encoded"] substringWithRange:NSMakeRange(index2, 1)]];
            index2++;
            }
    
    else   [_typingTimer invalidate];
        
}

@end
