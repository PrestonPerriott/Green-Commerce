//
//  LumenTableViewCell.m
//  Lumen3.0
//
//  Created by Preston Perriott on 1/24/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//


#import "VLAFloatingViewController.h"
#import "NSString+HTMLParse.h"


CGFloat const MaxBarHeight = 10;
CGFloat const MinBarHeight = 5;
CGFloat const NumOfBars = 7;


@interface VLAFloatingViewController ()

@property (nonatomic,strong)NSArray *ChartData;
@property (nonatomic, strong)NSArray *DailySymbols;
@property (nonatomic, strong)UILabel *PowerLabel;
@property (nonatomic, strong)UILabel *ScentLabel;
@property (nonatomic, strong)UILabel *InfoLabel;
@property (nonatomic, strong)UIView *viewDivider;
@property (nonatomic, strong)UIView *viewDivider2;
@property (nonatomic, strong)UIView *viewDivider3;
@property (nonatomic, strong)UIView *infoHolder;
@property (nonatomic, retain)NSIndexPath *WhichIndex;

@property (nonatomic,strong)NSArray *PhotoRef;
@property (nonatomic, strong)NSArray *TurnRef;






@end

@implementation VLAFloatingViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
    }
    return self;
}
- (instancetype)initWithIndexPath:(NSIndexPath*)path{
    self = [super init];
    if (self) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle =UIModalPresentationOverCurrentContext;
    
    }
    return self;
                                       
}
- (instancetype)initWithIndexPath:(NSIndexPath *)path andPhotoArray:(NSArray *)photos{
    self = [super init];
    if (self) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle =UIModalPresentationOverCurrentContext;
        //_PhotoRef = [[NSArray alloc]init];
        //_WhichIndex = [[NSIndexPath alloc]init];
        _PhotoRef = photos;
        _WhichIndex = path;
        
    }
    return self;
}
- (instancetype)initWithIndexPath:(NSIndexPath *)path andPhotoArray:(NSArray *)photos andTurnArray:(NSArray *)turns{
    self = [super init];
    if (self) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle =UIModalPresentationOverCurrentContext;
        //_PhotoRef = [[NSArray alloc]init];
        //_WhichIndex = [[NSIndexPath alloc]init];
        _PhotoRef = photos;
        _WhichIndex = path;
        _TurnRef = turns;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.view.frame)/2) - 40, CGRectGetWidth(self.view.frame), (CGRectGetHeight(self.view.frame)/2) + 40)];
   
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.viewContent.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)].CGPath;
    _viewContent.layer.mask = maskLayer;
    //_viewContent.backgroundColor = [UIColor clearColor];
    
    UIImage *BGImage = [UIImage imageNamed:@"GradientPlanner.jpg"];
    UIImageView *BGImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    BGImageView.contentMode = UIViewContentModeScaleAspectFill;
    BGImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    BGImageView.layer.masksToBounds = TRUE;
    BGImageView.image = BGImage;
    //[_viewContent addSubview:BGImageView];

    
    _viewContent.layer.shadowColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5].CGColor;
    _viewContent.layer.shadowOpacity = 0.5f;
    

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurEffectView.alpha =  1.00;
    [blurEffectView setOpaque:NO];
    
   
    
    [_viewContent addSubview:blurEffectView];
    
    
    
    [blurEffectView.centerXAnchor constraintEqualToAnchor:_viewContent.centerXAnchor].active = TRUE;
    [blurEffectView.topAnchor constraintEqualToAnchor:_viewContent.topAnchor].active = TRUE;
    [blurEffectView.widthAnchor constraintEqualToAnchor:_viewContent.widthAnchor].active = TRUE;
    [blurEffectView.heightAnchor constraintEqualToAnchor:_viewContent.heightAnchor].active = TRUE;
   
    [self.view addSubview:_viewContent];
    
    
    UIVibrancyEffect * effect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView * selectedBackgroundView = [[UIVisualEffectView alloc] initWithEffect:effect];
    selectedBackgroundView.autoresizingMask =
    UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    selectedBackgroundView.frame = _viewContent.bounds;
    UIView * view = [[UIView alloc] initWithFrame:selectedBackgroundView.bounds];
    view.backgroundColor = [UIColor colorWithWhite:.8f alpha:0.5f];
    view.autoresizingMask =
    UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [selectedBackgroundView.contentView addSubview:view];
    selectedBackgroundView = selectedBackgroundView;
    
    //[_viewContent addSubview:selectedBackgroundView];
    
    
    
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    //navBar.barTintColor = [[UIColor colorWithHexString:@"99CF26"]colorWithAlphaComponent:.45];
    navBar.barTintColor = [[UIColor colorWithHexString:@"A0522D"]colorWithAlphaComponent:.65];
    
    
    _navItem = [[UINavigationItem alloc] init];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(exit)];
    leftButton.tintColor = [UIColor whiteColor];
    _navItem.leftBarButtonItem = leftButton;
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveAndExit)];
    //_navItem.rightBarButtonItem = rightButton;
    navBar.items = @[_navItem];
    
    [_viewContent addSubview:navBar];
    
    UILabel *DayLabel = [[UILabel alloc]init];
    //DayLabel.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(navBar.frame)+10,100, 50);
    DayLabel.frame = CGRectMake(25, CGRectGetHeight(navBar.frame)+10,100, 50);
    DayLabel.text = [NSString stringWithFormat:@"You successfully got through Day %@",_WhichIndex] ;
    [DayLabel sizeToFit];
    DayLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    //[_viewContent addSubview:DayLabel];
    
    
    //MAybe UIVIew Warpper class for chart, so that we has padding on the side, maybe rounded corners

    
    NSLog(@"THis is the passed Array : %@", _PhotoRef);
    UIImage *PlaceImage = [[UIImage alloc]init];
    
    if ([[_PhotoRef objectAtIndex:_WhichIndex.row] isKindOfClass:[NSNull class]]) {
        NSLog(@"The Photo Object is Null %@", [_PhotoRef objectAtIndex:_WhichIndex.row] );
        
        PlaceImage = [UIImage imageNamed:@"No_image_available.jpg"];
    }else{
    
    NSString *ImageRef = [NSString stringWithFormat:@"%@",[[_PhotoRef objectAtIndex:_WhichIndex.row]objectAtIndex:0]];
    
   
    
    NSString *PlacesAPISTRING = @"AIzaSyASt7chKW_EroAwB-6-iCzUS-DPzW7KVqE";
    
    NSString *BaseString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=%@&key=%@", ImageRef, PlacesAPISTRING];
    
    NSLog(@"This is the baseString : %@", BaseString);
    
    PlaceImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:BaseString]]];
    
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:PlaceImage];
    //imageView.frame = CGRectMake(0, CGRectGetHeight(navBar.frame)+10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/4);
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = TRUE;
    imageView.alpha =.90;
    [self.view addSubview:imageView];
    
    [imageView.topAnchor constraintEqualToAnchor:navBar.bottomAnchor constant:5].active = TRUE;
    [imageView.widthAnchor constraintEqualToAnchor:navBar.widthAnchor constant:-30].active = TRUE;
    [imageView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.20].active = TRUE;
    [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = TRUE;
    
    
        _infoHolder =[[UIView alloc]init];
        _infoHolder.translatesAutoresizingMaskIntoConstraints = false;
        _infoHolder.layer.cornerRadius = 4;
        _infoHolder.backgroundColor = [UIColor colorWithHexString:@"A0522D"];
        _infoHolder.alpha = .85;
    _infoHolder.layer.masksToBounds = YES;
    
    UIBlurEffect *blurEffect2 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect2];
    EffectView.frame = self.view.bounds;
    EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    EffectView.alpha = .7;
    [_infoHolder addSubview:EffectView];
    
        [_viewContent addSubview:_infoHolder];
        [_viewContent bringSubviewToFront:_infoHolder];
    
    
        [_infoHolder.topAnchor constraintEqualToAnchor:imageView.bottomAnchor constant:4].active = TRUE;
        [_infoHolder.widthAnchor constraintEqualToAnchor:_viewContent.widthAnchor constant:-18].active = TRUE;
        [_infoHolder.bottomAnchor constraintEqualToAnchor:_viewContent.bottomAnchor constant:-4].active = TRUE;
        [_infoHolder.centerXAnchor constraintEqualToAnchor:_viewContent.centerXAnchor].active = TRUE;
    
    
    
    if (_TurnRef) {
        UITextView *firstMove = [[UITextView alloc]init];
        firstMove.text = @"Driving Directions to Route";
        firstMove.translatesAutoresizingMaskIntoConstraints = false;
        [firstMove sizeToFit];
        //firstMove.textContainer.lineBreakMode = 0;
        firstMove.textContainer.maximumNumberOfLines = 1;
        firstMove.userInteractionEnabled = NO;
        firstMove.font = [UIFont systemFontOfSize:18];
        firstMove.textColor = [UIColor whiteColor];
        firstMove.layer.cornerRadius = 5;
        firstMove.backgroundColor = [UIColor clearColor];
        [_infoHolder addSubview:firstMove];
        
        [firstMove.centerXAnchor constraintEqualToAnchor:_infoHolder.centerXAnchor].active = TRUE;
        [firstMove.widthAnchor constraintEqualToAnchor:_infoHolder.widthAnchor].active = TRUE;
        //[firstMove.heightAnchor constraintEqualToAnchor:_infoHolder.heightAnchor multiplier:1/[_TurnRef count]].active = TRUE;
        [firstMove.heightAnchor constraintEqualToConstant:30].active = TRUE;
        [firstMove.topAnchor constraintEqualToAnchor:_infoHolder.topAnchor constant:-5].active = TRUE;
        
        for (int i = 0; i < [_TurnRef count]; i++) {
            UITextView *textField  = [[UITextView alloc]init];
            textField.tag = i;
            textField.font = [UIFont systemFontOfSize:12];
            textField.translatesAutoresizingMaskIntoConstraints = false;
            textField.textContainer.lineBreakMode = 0;
            textField.textColor = [UIColor whiteColor];
            textField.textContainer.maximumNumberOfLines = 1;
            textField.userInteractionEnabled = NO;
            // [textField sizeToFit];
            textField.backgroundColor = [UIColor clearColor];
            //textField.textAlignment = NSTextAlignmentCenter;
            
            //Personal Category
            textField.text = [[_TurnRef objectAtIndex:i]stringByStrippingHTML];
//            textField.frame = CGRectMake(0, CGRectGetHeight(firstMove.frame)+(10*(i+1)), CGRectGetWidth(firstMove.frame), firstMove.frame.size.height);
            [_infoHolder addSubview:textField];
            
            [textField.topAnchor constraintEqualToAnchor:firstMove.bottomAnchor constant:(22)*(i+1)].active = TRUE;
            [textField.centerXAnchor constraintEqualToAnchor:_infoHolder.centerXAnchor].active = TRUE;
            [textField.widthAnchor constraintEqualToAnchor:firstMove.widthAnchor].active = TRUE;
            [textField.heightAnchor constraintEqualToAnchor:firstMove.heightAnchor multiplier:.75].active = TRUE;
            
            
        }
    }
    
  /*  if (_TurnRef) {
        for ( id object in _TurnRef) {
            UITextField *textField  = [[UITextField alloc]init];
            textField.tag = [object integerValue]+1;
            textField.text = object;
            textField.frame = CGRectMake(posx,posy,textWidth,textHeight);
            [self.view addSubview:textField];
        }
        
    }*/
    
   // UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DismissLumenInfo)];
    
    //[singleTap setNumberOfTapsRequired:1];
    //[imageView addGestureRecognizer:singleTap];
    
    [_viewContent addSubview:imageView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveAndExit {
    
}
-(void)DismissLumenInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
