//
//  LocationViewController.h
//  
//
//  Created by Preston Perriott on 10/15/16.
//
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "RPTDetailsView.h"
@import GoogleMaps;
@import GooglePlaces;
#import "VLAFloatingViewController.h"


@protocol LocationsSlideViewDelegate <NSObject>
-(void)PoppedController:(VLAFloatingViewController*)controller;
@end

@interface LocationViewController : UIViewController <RPTDetailsViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSDictionary *finalPoints;
    NSMutableArray *endLocations;
    NSMutableArray *startLocations;
    NSMutableArray *htmlInstructions;
    NSIndexPath *VLAFloatingPath;
}

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *textView;
@property (strong, nonatomic) UIImage *BackgroundImage;
@property (strong, nonatomic) UIImageView *BackgroundImageView;
@property (strong, nonatomic) GMSMapView *map;
@property (strong, nonatomic) GMSCameraPosition *camera;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSMutableArray *GooglePlacesArray;
@property (strong, nonatomic) NSDictionary *GooglePlacesDict;

@property (strong, nonatomic) NSMutableArray *GoogleResults;
@property (strong, nonatomic) NSMutableArray *GoogleResults2;

@property (strong, nonatomic) NSMutableArray *GoogleSubImages;
@property (strong, nonatomic) NSMutableArray *GoogleSubNames;
@property (strong, nonatomic) NSMutableArray *GoogleSubGeometry;
@property (strong, nonatomic) NSMutableArray *GoogleSubPlaceID;

@property (strong, nonatomic, readwrite) UITableView *PlacesTableView;

@property (strong, nonatomic) NSArray *longitudeArray;
@property (strong, nonatomic) NSArray *latitudeArray;
@property (nonatomic, retain, readonly) RPTDetailsView *detailsView;

@property  (nonatomic, copy)VLAFloatingViewController *Flaoting;
@property (nonatomic, retain)id <LocationsSlideViewDelegate>delegate;


@end
