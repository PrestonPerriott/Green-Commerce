//
//  LeftProfileViewController.m
//  GreenCommerce2.0
//
//  Created by Preston Perriott on 11/9/16.
//  Copyright © 2016 Preston Perriott. All rights reserved.
//

#import "LeftProfileViewController.h"

@interface LeftProfileViewController () <UITableViewDelegate, UITableViewDataSource, CNPPopupControllerDelegate>

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (strong, nonatomic)NSArray *aryMenu;

@property (strong, nonatomic) UIImageView *imgViewBackground;
@property (strong, nonatomic) UIWindow *window;
@end

@implementation LeftProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIButton *btnInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [btnInfo sizeToFit];
    [btnInfo addTarget:self action:@selector(handleInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem *bottomNavigationItem = [[UINavigationItem alloc] init];
    bottomNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnInfo];
    
    UINavigationBar *bottomBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-44, CGRectGetWidth(self.view.frame), 44)];
    bottomBar.items = @[bottomNavigationItem];
    [self.view addSubview:bottomBar];
    bottomBar.alpha = .25;
    
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 1.5) / 2.0f, self.view.frame.size.width, 54 * 3) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    
    self.aryMenu = @[
                     @"Profile",
                     @"Friends",
                     @"Events",
                     ];
    
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)handleInfo:(UIButton*)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"Copyright © Preston\n\nThird part libraries retain their rights.\n- Chameleon (The MIT License (MIT))\n- RESideMenu (The MIT License (MIT))\n- ActionSheetPicker-3.0 (BSD License)\n\nInformation is provided my Cannabis Reports\n- Almost Every Google API\n- AFNetworking (The MIT License (MIT))" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.aryMenu count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"ripta.cell.menu";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Italic" size:30];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.aryMenu[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(10,10,260,300)];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 350)];
    customView.backgroundColor = [UIColor lightGrayColor];
    customView.layer.cornerRadius = 4;
    [customView addSubview:webview];
    
    NSString *url=@"https://www.theweedblog.com/best-marijuana-events-2017/";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];

    button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:101.0/255.0 blue:161.0/255.0 alpha:1];
    button.layer.cornerRadius = 10;
    PopedWebView =[[CNPPopupController alloc] initWithContents:@[customView]];
    PopedWebView.theme = [CNPPopupTheme defaultTheme];
    PopedWebView.delegate = self;
    button.selectionHandler = ^(CNPPopupButton *button){
        
        [PopedWebView dismissPopupControllerAnimated:YES];
        
    };

    

    switch (indexPath.row) {
        case 0:
            break;
            case 1:
            break;
            case 2:
            //UIWebPAge
            [webview loadRequest:nsrequest];
            //[self.sideMenuViewController hideMenuViewController];
            [PopedWebView presentPopupControllerAnimated:YES];
            
            break;
        default:
            break;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 54;
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
