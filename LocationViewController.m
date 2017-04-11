//
//  LocationViewController.m
//
//
//  Created by Preston Perriott on 10/15/16.
//
//

#import "LocationViewController.h"




@interface LocationViewController () <CLLocationManagerDelegate>

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"*************************************************************************************************************************************************Location in Second View : %@", [_locationManager location]);
    
    [self setUpView:_locationManager];
    
    [self ScrapeGoogleData];
    
}
-(void)ScrapeGoogleData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=1500&types=park&sensor=true&key=AIzaSyD77Gd6FHFH8vgN2CCr1sQ-7qo9XTbhvYI",_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude];
    
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){
        if ([responseObject isKindOfClass:[NSArray class]]) {
            _GooglePlacesArray = responseObject;
            NSLog(@"Array Object: %@", _GooglePlacesArray);
            
        }else if ([responseObject isKindOfClass:[NSDictionary class]]){
            _GooglePlacesDict = responseObject;
           // NSLog(@"Dictionary Object: %@", _GooglePlacesDict);
            
            _GoogleResults = [[NSMutableArray alloc]init];
            _GoogleResults = [_GooglePlacesDict valueForKey:@"results"];
            NSLog(@"Object Google Results holds : %@", _GoogleResults);
            
            //Passing the array "_GoogleResults" with just results in it to func
            [self PassGoogleResults:_GoogleResults];
            
            //This works as well
            //_GoogleResults = [[_GooglePlacesDict valueForKeyPath:@"results.place_id"]objectAtIndex:1];
            
            
            
            //Remember that _googleResults is an array
            //NSLog(@"**************************************************** %@",[_GoogleResults valueForKey:@"place_id"]);
            //NSLog(@"***************************************** %@", [_GoogleResults valueForKey:@"name"]);
            
            //NSArray *array = [[_GooglePlacesDict valueForKeyPath:@"results.name"]objectAtIndex:1];
            // NSLog(@"Results.Name Object at index 1 array :%@", array);
            
        }
    }failure:^(NSURLSessionTask *task, NSError *error){
        
    }];
    
}
-(void)PassGoogleResults:(NSMutableArray *)googeResults{
    _GoogleResults2 = googeResults;
    _GoogleSubNames = [[NSMutableArray alloc]init];
    _GoogleSubImages = [[NSMutableArray alloc] init];
    _GoogleSubPlaceID = [[NSMutableArray alloc] init];
    _GoogleSubGeometry = [[NSMutableArray alloc] init];
    
    
    
    
    [_GoogleSubNames addObjectsFromArray:[_GoogleResults2 valueForKey:@"name"]];
    
    for (int x = 0; x < [_GoogleResults2 count]; x++) {
        [_GoogleSubImages addObjectsFromArray:[[_GoogleResults2 valueForKey:@"photos"] valueForKey:@"photo_reference"]];
    }
    
    
    
    
    
    [_GoogleSubPlaceID addObjectsFromArray:[_GoogleResults2 valueForKey:@"place_id" ]];
    
    
    [_GoogleSubGeometry addObjectsFromArray:[_GoogleResults2 valueForKey:@"geometry"]];
    
    
    
   // NSLog(@"Names : %@", _GoogleSubNames);
   // NSLog(@"Place ID's : %@", _GoogleSubPlaceID);
   // NSLog(@"Locations : %@", _GoogleSubGeometry);
    NSLog(@"Image Tokens : %@", _GoogleSubImages);
    
    if ([_GoogleSubNames count] == [_GoogleSubPlaceID count]) {
        if ([_GoogleSubGeometry count] == [_GoogleSubImages count]) {
        }
        NSLog(@"The Objects are equal ");
    }
    
    [_PlacesTableView reloadData];
    
    
    //Maybe a function that takes the geometry, and updates the map with it?
    [self StoreMapValues:_GoogleSubGeometry];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)StoreMapValues:(NSArray *)locations{
    
    
    NSArray *latLong = [locations valueForKey:@"location"];
    NSLog(@"%@ :", latLong);
    
    NSArray *lat = [latLong valueForKey:@"lat"];
    
    NSLog(@"%@ :", lat);
    
    NSArray *longit = [latLong valueForKey:@"lng"];
    
    NSLog(@"%@ ", longit);
    
    _latitudeArray = lat;
    _longitudeArray = longit;
}
-(void)setUpView:(CLLocationManager *)location {
    location = _locationManager;
    _BackgroundImage = [UIImage imageNamed:@"ParksBG.jpg"];
    _BackgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _BackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _BackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _BackgroundImageView.layer.masksToBounds = YES;
    _BackgroundImageView.image = _BackgroundImage;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_BackgroundImageView];
    
    self.navigationItem.title = @"L O C A L  P A R K S";
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * EffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    EffectView.frame = self.view.bounds;
    EffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    EffectView.alpha = .7;
    [self.view addSubview:EffectView];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    _containerView = [[UIView alloc] init];
    _containerView.translatesAutoresizingMaskIntoConstraints = false;
    _containerView.layer.cornerRadius = 5;
    _containerView.layer.masksToBounds = YES;
    _containerView.backgroundColor = [UIColor colorWithRed:103.0/ 255.0 green:96.0/255.0 blue:135/255.0 alpha:.32];
    
    
    [self.view addSubview:_containerView];
    
    [_containerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = TRUE;
    [_containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:80].active = TRUE;
    [_containerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-24].active =TRUE;
    [_containerView.heightAnchor constraintEqualToConstant:350].active = TRUE;
    
    
    _camera = [GMSCameraPosition cameraWithLatitude:location.location.coordinate.latitude longitude:location.location.coordinate.longitude zoom:10];
    
    _map = [[GMSMapView alloc]init];
    _map.camera = _camera;
    _map.translatesAutoresizingMaskIntoConstraints = false;
    _map.layer.cornerRadius = 5;
    _map.layer.masksToBounds = YES;
    _map.contentMode = UIViewContentModeScaleAspectFill;
    _map.alpha = .54;
    [_map setMyLocationEnabled:TRUE];
    [_containerView addSubview:_map];
    
    
    [_map.centerXAnchor constraintEqualToAnchor:_containerView.centerXAnchor].active = TRUE;
    [_map.centerYAnchor constraintEqualToAnchor:_containerView.centerYAnchor].active = TRUE;
    [_map.widthAnchor constraintEqualToAnchor:_containerView.widthAnchor].active = TRUE;
    [_map.heightAnchor constraintEqualToAnchor:_containerView.heightAnchor].active = TRUE;
    
    _textView = [[UIView alloc] init];
    _textView.translatesAutoresizingMaskIntoConstraints = false;
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.backgroundColor = [UIColor colorWithRed:103.0/ 255.0 green:96.0/255.0 blue:135/255.0 alpha:.32];
    [self.view addSubview:_textView];
    
    [_textView.centerXAnchor constraintEqualToAnchor:_containerView.centerXAnchor].active = TRUE;
    [_textView.topAnchor constraintEqualToAnchor:_containerView.bottomAnchor constant:10].active = TRUE;
    [_textView.widthAnchor constraintEqualToAnchor:_containerView.widthAnchor constant:-24].active =TRUE;
    [_textView.heightAnchor constraintEqualToAnchor:_containerView.heightAnchor multiplier:.6].active = TRUE;
    
    _PlacesTableView = ({
        UITableView *tableView = [[UITableView alloc] init];
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.scrollEnabled = YES;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = YES;
        tableView;
    });
    [_textView addSubview:_PlacesTableView];
    
    [_PlacesTableView.centerXAnchor constraintEqualToAnchor:_textView.centerXAnchor].active = TRUE;
    [_PlacesTableView.topAnchor constraintEqualToAnchor:_textView.topAnchor].active = TRUE;
    [_PlacesTableView.widthAnchor constraintEqualToAnchor:_textView.widthAnchor].active = TRUE;
    [_PlacesTableView.heightAnchor constraintEqualToAnchor:_textView.heightAnchor].active = TRUE;
    
    UIBarButtonItem *Home = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"IconHome@2x copy.png"] style:UIBarButtonItemStyleDone target:self action:@selector(PreviousView)];
    
    self.navigationItem.leftBarButtonItem = Home;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:116.0/ 255.0 green:182.0/255.0 blue:181/255.0 alpha:.52];
    
    
    _detailsView = [[RPTDetailsView alloc] initWithFrame:CGRectZero withDelegate:self];
    _detailsView.translatesAutoresizingMaskIntoConstraints = false;
    _detailsView.alpha = .67;
    [_containerView addSubview:_detailsView];
    [_containerView bringSubviewToFront:_detailsView];
    
    
    [_detailsView.rightAnchor constraintEqualToAnchor: _containerView.rightAnchor].active = TRUE;
    [_detailsView.topAnchor constraintEqualToAnchor:_containerView.topAnchor].active = TRUE;
    [_detailsView.heightAnchor constraintEqualToConstant:80].active = TRUE;
    [_detailsView.widthAnchor constraintEqualToConstant:50].active = TRUE;
    
    
    //[_detailsView.heightAnchor constraintEqualToAnchor:_containerView.heightAnchor multiplier:.2].active = TRUE;
    //[_detailsView.widthAnchor constraintEqualToAnchor:_containerView.widthAnchor multiplier:.2].active = TRUE;
    
    
    
}
-(void)PreviousView{
    
    
    [self.navigationController dismissViewControllerAnimated:TRUE completion:nil];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VLAFloatingPath = indexPath;
    
    switch (indexPath.row) {
        case 0:
            /*  _camera = [GMSCameraPosition cameraWithLatitude:[_latitudeArray[indexPath.row] floatValue] longitude:[_longitudeArray[indexPath.row]floatValue] zoom:20];
             
             _map.camera = _camera;*/
        {
            
            [_map clear];
            CLLocation* AtNow = [[CLLocation alloc]initWithLatitude:_locationManager.location.coordinate.latitude longitude:_locationManager.location.coordinate.longitude];
            
            CLLocation* GoingTo = [[CLLocation alloc]initWithLatitude:[_latitudeArray [indexPath.row]floatValue] longitude:[_longitudeArray [indexPath.row]floatValue]];
            
            [self drawRoute:AtNow forDestination:GoingTo];
            
         /*   [CATransaction begin];
            [CATransaction setValue:[NSNumber numberWithInteger:2] forKey:kCATransactionAnimationDuration];
            GMSCameraPosition *postiton = [GMSCameraPosition cameraWithLatitude:GoingTo.coordinate.latitude longitude:GoingTo.coordinate.longitude zoom:15];
            [_map animateToCameraPosition:postiton];
            [CATransaction commit];*/
            
            
        }
            break;
        case 1:
        {
            [_map clear];
            CLLocation* AtNow = [[CLLocation alloc]initWithLatitude:_locationManager.location.coordinate.latitude longitude:_locationManager.location.coordinate.longitude];
            
            CLLocation* GoingTo = [[CLLocation alloc]initWithLatitude:[_latitudeArray [indexPath.row]floatValue] longitude:[_longitudeArray [indexPath.row]floatValue]];
            
            [self drawRoute:AtNow forDestination:GoingTo];
            /*
            [CATransaction begin];
            [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
            [_map animateToLocation:CLLocationCoordinate2DMake([_latitudeArray [indexPath.row]floatValue], [_longitudeArray [indexPath.row]floatValue])];
            [_map animateToZoom:19];
            [_map animateToViewingAngle:45];
            
            [CATransaction commit];*/
        }
            break;
        default:
        {
            [_map clear];
//            [CATransaction begin];
//            [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
//            [_map animateToLocation:CLLocationCoordinate2DMake([_latitudeArray [indexPath.row]floatValue], [_longitudeArray [indexPath.row]floatValue])];
//            [_map animateToZoom:19];
//            [_map animateToViewingAngle:45];
//            
//            [CATransaction commit];
            
            CLLocation* AtNow = [[CLLocation alloc]initWithLatitude:_locationManager.location.coordinate.latitude longitude:_locationManager.location.coordinate.longitude];
            
            CLLocation* GoingTo = [[CLLocation alloc]initWithLatitude:[_latitudeArray [indexPath.row]floatValue] longitude:[_longitudeArray [indexPath.row]floatValue]];
            
            [self drawRoute:AtNow forDestination:GoingTo];
            
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if ([_GoogleSubNames count] > 0) {
        
        return [_GoogleSubNames count] ;
    }else{
        
        return 1 ;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Italic" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectionStyle =  UITableViewCellSelectionStyleDefault;
        
    }
    
    //NSArray *titles = @[@"Main Products", @"Subscription Zones", @"Mobile Site", @"Change Zip", @"Log Out"];
    
    NSArray *titles = _GoogleSubNames;
    
    // NSArray *images = @[@"IconHome@2x.png", @"IconCalendar@2x.png", @"IconProfile@2x.png", @"IconSettings@2x.png", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
    // cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    //When we change the Neighborhood sign background to white, we should change the image colors to green
    //cell.imageView.tintColor = [UIColor colorWithRed:34.0/255.0 green:139.0/255.0 blue:34.0/255.0 alpha:.7];
    //cell.textLabel.textColor = [UIColor colorWithRed:34.0/255.0 green:139.0/255.0 blue:34.0/255.0 alpha:.7];
    //cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)detailsViewDidSelectInfoButton:(RPTDetailsView*)view {
    
    if (VLAFloatingPath && _GoogleSubImages) {
        VLAFloatingViewController *floating = [[VLAFloatingViewController alloc]initWithIndexPath:VLAFloatingPath andPhotoArray:_GoogleSubImages andTurnArray:htmlInstructions];
        [self presentViewController:floating animated:YES completion:nil];
    }
    
    
}
- (void)detailsViewDidSelectCurrentLocationButton:(RPTDetailsView*)view {
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [_locationManager requestWhenInUseAuthorization];
    _locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [_locationManager stopUpdatingLocation];
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
    [_map animateToLocation:CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude)];
    [_map animateToZoom:19];
    [_map animateToViewingAngle:45];
    
    [CATransaction commit];
}
- (void)drawRoute:(CLLocation*)myOrigin forDestination:(CLLocation*)myDestination
{
    [self fetchPolylineWithOrigin:myOrigin destination:myDestination completionHandler:^(GMSPolyline *polyline)
     {
         if(polyline)
             polyline.map = _map;
     }];
}

- (void)fetchPolylineWithOrigin:(CLLocation *)origin destination:(CLLocation *)destination completionHandler:(void (^)(GMSPolyline *))completionHandler
{
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    NSString *APIString = [NSString stringWithFormat:@"AIzaSyC3c3nqkPiZRg_A0akZ7S14sEThLpadYP0"];
    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&key=%@", directionsAPI, originString, destinationString, APIString];
    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
    
    
    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error){
            if(completionHandler)
            completionHandler(nil);
            return;
            }
        
            // run completionHandler on main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completionHandler){
                NSArray *routesArray = [json objectForKey:@"routes"];
              //  GMSPolyline *polyline = nil;
            
                    NSDictionary *routeDict = [routesArray objectAtIndex:0];
                    NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                    NSArray *stepsPolyline = [routeDict objectForKey:@"legs"];
                    NSArray *stepsArray = [[stepsPolyline objectAtIndex:0]objectForKey:@"steps"];
                
                NSMutableArray *UGh = [[NSMutableArray alloc]init];
                for (int x  = 0; x < [stepsArray count]; x++)
                    {
                    [UGh insertObject:[stepsArray objectAtIndex:x] atIndex:x];}
                
                endLocations = [[NSMutableArray alloc]init];
                startLocations = [[NSMutableArray alloc]init];
                htmlInstructions = [[NSMutableArray alloc]init];
                for (int x = 0; x < [UGh count]; x++) {
                    [endLocations insertObject:[[UGh objectAtIndex:x] valueForKey:@"end_location"] atIndex:x];
                    [startLocations insertObject:[[UGh objectAtIndex:x]valueForKey:@"start_location"] atIndex:x];
                    [htmlInstructions insertObject:[[UGh objectAtIndex:x] valueForKey:@"html_instructions"] atIndex:x];
                }
                    NSArray *firstPlace = [stepsArray objectAtIndex:0];
                NSDictionary *BeginTrip = [firstPlace valueForKey:@"end_location"];
                NSDictionary *NextStop = [firstPlace valueForKey:@"start_location"];
                    NSString *points = [routeOverviewPolyline objectForKey:@"points"];
               // NSLog(@"SOME JSON : %@", json);
                NSLog(@"Legs inside JSON : %@", stepsPolyline);
                NSLog(@"Steps inside of Legs : %@", stepsArray);
                NSLog(@"**********ALL Directions Final : %@", UGh);
               // NSLog(@"UUUGHGGHGHGHGHGGHG %@: ", BeginTrip);
                    GMSPath *path = [GMSPath pathFromEncodedPath:points];
                
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        completionHandler(polyline);
                
            finalPoints = [NSDictionary dictionaryWithObjectsAndKeys:
                           BeginTrip, @"start",
                           NextStop , @"next",
                           nil];
                
                NSLog(@"THE STEPS TO TAKE ARE : %@ AND** %@", startLocations, endLocations);
                
                NSLog(@"HTML Directions for slide UP : %@", htmlInstructions);
                
    [UIView transitionWithView:_map duration:1.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        
                        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
        [CATransaction setAnimationDuration:7];
        
        [_map animateToZoom:15];
//        [_map animateToLocation:CLLocationCoordinate2DMake([[[startLocations objectAtIndex:0]valueForKey:@"lat"]floatValue ], [[[startLocations objectAtIndex:0]valueForKey:@"lng"]floatValue])];
            [CATransaction commit];
                        
                        [CATransaction commit];
                    }completion:^(BOOL done){
                        
//                        [CATransaction begin];
//                        [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
//                        [CATransaction setAnimationDuration:15];
//                        [_map animateToLocation:CLLocationCoordinate2DMake([[[startLocations objectAtIndex:1]valueForKey:@"lat"]floatValue ], [[[startLocations objectAtIndex:1]valueForKey:@"lng"]floatValue])];
//                        [CATransaction commit];
//                       
//                             }];

                    }];
                
            }
        });
            }];
    [fetchDirectionsTask resume];
}

@end
