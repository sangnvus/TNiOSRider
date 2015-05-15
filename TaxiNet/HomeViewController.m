//
//  HomeViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "REFrostedViewController.h"
#import "PaymentViewController.h"
@interface HomeViewController () {
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;
    MKPlacemark *placeFrom, *placeTo;
    int locationTabPosition;
    UITapGestureRecognizer *gestureFrom, *gestureTo,*gestureGray;
    MKRoute *routeDetails;
    NSMutableArray *arrDataSearched;
    NSInteger selectTo;
    BOOL fromselect;
    AppDelegate*appdelegate;
    BOOL finTaxi;
    BOOL GetPoint;
    BOOL clickAnnonation;
    BOOL addAnnonation;
    BOOL regionSelect;
    UITableView *mTableViewSuggest;
    UIView *background;
    BOOL selectPay;
}
@property (nonatomic, strong) MKLocalSearch *localSearch;

@end
@implementation HomeViewController
@synthesize mLocationFrom,mLocationTo,mImageFocus,mapview,viewLocationFrom,viewLocationTo,homeviewmap;

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //search setup
    fromselect=FALSE;
    regionSelect=FALSE;
    finTaxi=FALSE;
    GetPoint=FALSE;
    clickAnnonation=FALSE;
    addAnnonation=FALSE;
    selectPay=FALSE;
    [[NSUserDefaults standardUserDefaults] setObject:appdelegate.lontitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] setObject:appdelegate.latitude forKey:@"latitude"];
    self.mSearchBar.delegate = self;
    arrDataSearched = [[NSMutableArray alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    mTableViewSuggest = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mSearchBar.frame.origin.y + self.mSearchBar.frame.size.height, screenWidth,0)];
    mTableViewSuggest.delegate = self;
    mTableViewSuggest.dataSource = self;
    background.hidden=YES;

    [mTableViewSuggest setHidden:YES];
    mTableViewSuggest.backgroundColor =[UIColor whiteColor];
    background=[[UIView alloc] initWithFrame: CGRectMake ( 0, 60, 320, 560)];
    background.backgroundColor =[UIColor colorWithRed:.1 green:.1 blue:.1 alpha: .4];
    [self.view addSubview:background];
    [self.view addSubview:mTableViewSuggest];
    background.hidden=YES;

    //set anchor point focus point
    mImageFocus.layer.anchorPoint = CGPointMake(0.5, 1.0);
    mapview.delegate = self;
    
    
    // Map View
    //[self.mapview addAnnotations:[self annotations]];
    mImageFocus.hidden=YES;
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:1];
    
    gestureFrom = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectLocationFrom:)];
    [self.viewLocationFrom addGestureRecognizer:gestureFrom];
    gestureGray = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(dismissDetail:)];
    [self.grayView addGestureRecognizer:gestureGray];
    
    gestureTo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(selectLocationTo:)];
    [self.viewLocationTo addGestureRecognizer:gestureTo];
    
    [self selectLocationFrom:gestureFrom];
    
    [self.viewLocationFrom setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f
                                                      green:244.0f/255.0f
                                                       blue:254.0f/255.0f
                                                      alpha:1.0f]];
    [self.findMyTaxi setBackgroundColor:[UIColor colorWithRed:27.0f/255.0f
                                                        green:159.0f/255.0f
                                                         blue:252.0f/255.0f
                                                        alpha:1.0f]];
    


    selectTo=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"ShowViewDetail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"getRiderInfo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"HidenViewDetail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"hidenGrayView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"KICK_OUT" object:nil];

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"KICK_OUT"]) {
        [self kickOut];
    }
    if ([[notification name]isEqualToString:@"hidenGrayView"]) {
        self.grayView.hidden=YES;
    }
    if ([[notification name]isEqualToString:@"ShowViewDetail"]) {
        [self changeViewDetail];
    }
    if ([[notification name]isEqualToString:@"HidenViewDetail"])
    {
        self.btnWaiting.hidden=NO;
        [self.btnWaiting addTarget:self
                            action:@selector(CancelReques)
                  forControlEvents:UIControlEventTouchUpInside];
        clickAnnonation=TRUE;
//        [self.btnWaiting setTitle:@"Waiting Request ......" forState:UIControlStateNormal];
    }
    if ([[notification name]isEqualToString:@"getRiderInfo"]) {
        NSLog(@"push :%@",appdelegate.RiderInfo);
        NSString *status=[appdelegate.RiderInfo objectForKey:@"status"];
        if ([status isEqualToString:@"CA"]) {
            self.btnWaiting.hidden=YES;
            [self changeViewDetail];
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Status Request Taxi" message:@"Your request not acepted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
        }
        else if ([status isEqualToString:@"PI"])
        {
            [self.btnWaiting setTitle:@"Please Wait Taxi ......" forState:UIControlStateNormal];
            [self.btnWaiting addTarget:self
                                action:@selector(CancelReques)
             forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([status isEqualToString:@"PD"])
        {
            self.btnWaiting.hidden=YES;
            clickAnnonation=FALSE;
            [self changeViewDetail];
            NSInteger toRemoveCount = mapview.annotations.count;
            NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
            for (id annotation in mapview.annotations)
                if (annotation != mapview.userLocation)
                    [toRemove addObject:annotation];
            [mapview removeAnnotations:toRemove];
            [self.findMyTaxi setTitle:@"Find My Taxi" forState:UIControlStateNormal];
            self.mImageFocus.hidden=NO;
            GetPoint=FALSE;
            self.mLocationTo.text=@"";
            addAnnonation=TRUE;
            [self selectLocationFrom:gestureFrom];
            [self.mapview removeOverlays:self.mapview.overlays];
            [self.viewLocationFrom addGestureRecognizer:gestureFrom];
            [self.viewLocationTo addGestureRecognizer:gestureTo];

        }
        else if ([status isEqualToString:@"TC"])
        {
            PaymentViewController *payment = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
            payment.vcParent = self;
            [self presentPopupViewController:payment animated:YES completion:^(void) {
                NSLog(@"popup view presented");
            }];
            selectPay=TRUE;
            self.grayView.hidden=NO;

        }
    }

}
-(void)kickOut
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"AppLogin" bundle: nil];
    LoginViewController  *controller = (LoginViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    NSString* riderId = [[NSUserDefaults standardUserDefaults] stringForKey:@"riderId"];
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [unity LogOut:riderId];
}
-(void)CancelReques
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Request Taxi" message:@"Do you want cancel Taxi" delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:@"OK", nil];
    [errorAlert show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do your action
    }else{
        self.btnWaiting.hidden=YES;
        clickAnnonation=FALSE;
        [self changeViewDetail];
        NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestid"];
        NSString* riderid = [[NSUserDefaults standardUserDefaults] stringForKey:@"riderId"];
        [unity updateTrip:requestid userID:riderid status:@"CA" owner:self];
        
    }
}

-(void)changeViewDetail
{
//    [UIView setAnimationDuration:0.5];
//    CGRect frame= mapview.frame;
//    frame.size.height=390;
//    mapview.frame=frame;
//    [UIView commitAnimations];
    [UIView setAnimationDuration:0.5];
    CGRect framedetail= self.ViewDetail.frame;
    framedetail.origin.y=5;
    self.ViewDetail.frame=framedetail;
    [UIView commitAnimations];
}
-(void)dismissDetail:(UITapGestureRecognizer *)recognizer
{
    if (selectPay==TRUE) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"paymentdetail" object:self];
    }
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissDetail" object:self];

}
- (void)selectLocationFrom:(UITapGestureRecognizer *)recognizer {
    [mImageFocus setImage:[UIImage imageNamed:@"fromMap.png"]];

    if (fromselect==TRUE) {
        [self.viewLocationFrom setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f
                                                                green:244.0f/255.0f
                                                                 blue:254.0f/255.0f
                                                                alpha:1.0f]];
        [self.viewLocationTo setBackgroundColor:[UIColor whiteColor]];
        NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
        NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [latitudeFrom floatValue] ;
        region.center.longitude = [longitudeFrom floatValue];
        region.span.longitudeDelta = 0.05f;
        region.span.latitudeDelta = 0.05f;
        [self.mapview setRegion:region animated:YES];
        locationTabPosition = 0;
        
        NSInteger toRemoveCount = mapview.annotations.count;
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
        for (id annotation in mapview.annotations)
            if (annotation != mapview.userLocation)
                [toRemove addObject:annotation];
        [mapview removeAnnotations:toRemove];
//        JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
//        annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
//        annotation.image = [UIImage imageNamed:@"fromMap.png"];
//        
//        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
        
        if (addAnnonation==FALSE) {
            NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
            NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
            JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
            annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
            annotationTo.image = [UIImage imageNamed:@"toMap.png"];
            [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
        }
        addAnnonation=FALSE;
    }
    regionSelect=TRUE;

}
- (void)selectLocationTo:(UITapGestureRecognizer *)recognizer {
    
    [self.viewLocationTo setBackgroundColor:[UIColor colorWithRed:224.0f/255.0f
                                                            green:244.0f/255.0f
                                                             blue:254.0f/255.0f
                                                            alpha:1.0f]];
    
    [self.viewLocationFrom setBackgroundColor:[UIColor whiteColor]];
    [mImageFocus setImage:[UIImage imageNamed:@"toMap.png"]];
    fromselect=TRUE;
    mLocationTo.hidden=NO;
    self.mSuggest.hidden=YES;
    self.mLocationCityTo.hidden=NO;
    NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
    NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitudeTo floatValue] ;
    region.center.longitude = [longitudeTo floatValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
    locationTabPosition = 1;
    
    NSInteger toRemoveCount = mapview.annotations.count;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
    for (id annotation in mapview.annotations)
        if (annotation != mapview.userLocation)
            [toRemove addObject:annotation];
    [mapview removeAnnotations:toRemove];
//    JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
//    annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
//    annotationTo.image = [UIImage imageNamed:@"toMap.png"];
//    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
    
    
    NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
    NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
    JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
    annotation.image = [UIImage imageNamed:@"fromMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
    regionSelect=FALSE;
}

- (IBAction)waitingTaxi:(id)sender {
}

- (IBAction)setMylocation:(id)sender {
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitude doubleValue] ;
    region.center.longitude = [longitude doubleValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitudeTo"];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitudeTo"];
    [self.mapview setRegion:region animated:YES];
}

- (IBAction)BookNow:(id)sender {
    // add anonator map from-to
        NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
        NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitude floatValue] ;
    region.center.longitude = [longitude floatValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
    
    if (finTaxi==FALSE) {
        NSInteger toRemoveCount = mapview.annotations.count;
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
        for (id annotation in mapview.annotations)
            if (annotation != mapview.userLocation)
                [toRemove addObject:annotation];
        [mapview removeAnnotations:toRemove];
        NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
        NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
        NSLog(@"location: long: %@ lati: %@",longitudeFrom,latitudeFrom);
        JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
        annotation.image = [UIImage imageNamed:@"fromMap.png"];
        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
        
        NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
        NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
        JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
        annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
        annotationTo.image = [UIImage imageNamed:@"toMap.png"];
        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
        
        // get near taxi
        dispatch_async(dispatch_get_main_queue(), ^{
            [unity getNearTaxi:latitudeFrom andLongtitude:longitudeFrom owner:self];
            //        [self.mapview addAnnotations:[self annotations]];
        });
        
        // find way
        [self.mapview removeOverlays:self.mapview.overlays];
        
        MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
        
        [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placeFrom]];
        [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placeTo]];
        
        directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
        
        MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
        
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (error) {
                NSLog(@"Error %@", error.description);
            } else {
                routeDetails = response.routes.lastObject;
                [self.mapview addOverlay:routeDetails.polyline];
                //            for (int i = 0; i < routeDetails.steps.count; i++) {
                //                MKRouteStep *step = [routeDetails.steps objectAtIndex:i];
                //                NSString *newStep = step.instructions;
                //                NSLog(@"Step:%@",newStep);
                //            }
            }
        }];
        CLLocation *pinLocation = [[CLLocation alloc]
                                   initWithLatitude:placeFrom.coordinate.latitude
                                   longitude:placeFrom.coordinate.longitude];
        
        CLLocation *userLocation = [[CLLocation alloc]
                                    initWithLatitude:placeTo.coordinate.latitude
                                    longitude:placeTo.coordinate.longitude];
        
        CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
        NSLog(@"distance: %.1f km",distance/1000);
        NSString *distanceString = [NSString stringWithFormat:@"%.1f km", distance/1000];

        [[NSUserDefaults standardUserDefaults] setValue:distanceString forKey:@"distance"];
        [self.findMyTaxi setTitle:@"Change Trip" forState:UIControlStateNormal];
        self.mImageFocus.hidden=YES;
        GetPoint=TRUE;
        finTaxi=TRUE;
        [self.viewLocationFrom removeGestureRecognizer:gestureFrom];
        [self.viewLocationTo removeGestureRecognizer:gestureTo];
    }
    else if(finTaxi==TRUE)
    {
        [self.mapview removeOverlays:self.mapview.overlays];
        self.mImageFocus.hidden=NO;
        [self.findMyTaxi setTitle:@"Find My Taxi" forState:UIControlStateNormal];
        finTaxi=FALSE;
        GetPoint=FALSE;
        [self.viewLocationFrom addGestureRecognizer:gestureFrom];
        [self.viewLocationTo addGestureRecognizer:gestureTo];
        
        NSInteger toRemoveCount = mapview.annotations.count;
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
        for (id annotation in mapview.annotations)
            if (annotation != mapview.userLocation)
                [toRemove addObject:annotation];
        [mapview removeAnnotations:toRemove];
        if (regionSelect==TRUE) {
            NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
            NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
            MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
            region.center.latitude = [latitudeFrom floatValue] ;
            region.center.longitude = [longitudeFrom floatValue];
            region.span.longitudeDelta = 0.05f;
            region.span.latitudeDelta = 0.05f;
            [self.mapview setRegion:region animated:YES];
            
            NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
            NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
            JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
            annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
            annotationTo.image = [UIImage imageNamed:@"toMap.png"];
            [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
        }
        else
        {
            [self.mapview removeOverlays:self.mapview.overlays];
            NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
            NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
            MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
            region.center.latitude = [latitudeTo floatValue] ;
            region.center.longitude = [longitudeTo floatValue];
            region.span.longitudeDelta = 0.05f;
            region.span.latitudeDelta = 0.05f;
            [self.mapview setRegion:region animated:YES];
            
            NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
            NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
            JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
            annotation.image = [UIImage imageNamed:@"fromMap.png"];
            [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
        }
    }
}

 
-(void)zoomInToMyLocation
{
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitude doubleValue] ;
    region.center.longitude = [longitude doubleValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitudeTo"];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitudeTo"];
    [self.mapview setRegion:region animated:YES];
    mImageFocus.hidden=NO;
}
-(void)checkGetnearTaxi
{
    for (id json in self.nearTaxi) {
        NSLog(@"JSON:%@",json);
        NSString *latitu=[json objectForKey:@"latitude"];
        NSString *lontitu=[json objectForKey:@"longitude"];
        JPSThumbnail *empire = [[JPSThumbnail alloc] init];
        empire.image = [UIImage imageNamed:@"locatorTaxi.png"];
        empire.coordinate = CLLocationCoordinate2DMake([latitu floatValue], [lontitu floatValue]);
        empire.disclosureBlock =  ^{
            [UIView beginAnimations:@"animateAddContentView" context:nil];
            [UIView setAnimationDuration:0.4];
            //            self.ViewDetail.hidden=YES;
            [UIView setAnimationDuration:0.5];
            CGRect framedetail= self.ViewDetail.frame;
            framedetail.origin.y=-500;
            self.ViewDetail.frame=framedetail;
            [UIView commitAnimations];
//            CGRect frame= mapview.frame;
//            frame.size.height=510;
//            mapview.frame=frame;
//            [UIView commitAnimations];
            self.grayView.hidden=NO;
            DetailTaxi *detailTaxi = [[DetailTaxi alloc] initWithNibName:@"DetailTaxi" bundle:nil];
            detailTaxi.vcParent = self;
            detailTaxi.dataTaxi=json;
            [self presentPopupViewController:detailTaxi animated:YES completion:^(void) {
                NSLog(@"popup view presented");
            }];
        };
        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
        
    }
    
    
    
}
- (void) getReverseGeocode:(CLLocationCoordinate2D) coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocationCoordinate2D myCoOrdinate;
    
    myCoOrdinate.latitude = coordinate.latitude;
    myCoOrdinate.longitude = coordinate.longitude;
    NSString *lotu = [NSString stringWithFormat:@"%.8f", coordinate.longitude];
    NSString *lati = [NSString stringWithFormat:@"%.8f", coordinate.latitude];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:myCoOrdinate.latitude longitude:myCoOrdinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"failed with error: %@", error);
             return;
         }
         if(placemarks.count > 0)
         {
             NSString *address = @"";
             NSString *city = @"";
             NSString *nameStreet = @"";

             CLPlacemark *placemark = placemarks[0];
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             } else {
                 address = @"Address Not Founded";
             }
             if([placemark.addressDictionary objectForKey:@"Name"] != NULL) {
                 nameStreet = [placemark.addressDictionary objectForKey:@"Name"];
             } else {
                 nameStreet = @"Address Not Founded";
             }
             if ([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"City"];
             else
             {
                 NSArray *myArrayAdress = [address componentsSeparatedByString:@","];
                 if (myArrayAdress.count==2) {
                     city=[NSString stringWithFormat:@"%@",[myArrayAdress objectAtIndex:0]];
                 }
                 else if (myArrayAdress.count==3)
                 {
                     city=[NSString stringWithFormat:@"%@",[myArrayAdress objectAtIndex:1]];
                 }
                 else if (myArrayAdress.count==4)
                 {
                     city=[NSString stringWithFormat:@"%@",[myArrayAdress objectAtIndex:2]];
                 }
             }
             if (locationTabPosition == 0) {
                 if (GetPoint==FALSE) {
                     mLocationFrom.text = nameStreet;
                     self.mLocationCityFrom.text=city;
                     [[NSUserDefaults standardUserDefaults] setObject:nameStreet forKey:@"adressFrom"];
                 }

                 placeFrom = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
                 [[NSUserDefaults standardUserDefaults] setObject:lotu forKey:@"longitudeFrom"];
                 [[NSUserDefaults standardUserDefaults] setObject:lati forKey:@"latitudeFrom"];
                 
             } else {
                 if (GetPoint==FALSE) {
                     mLocationTo.text = nameStreet;
                     [[NSUserDefaults standardUserDefaults] setObject:nameStreet forKey:@"adressTo"];
                     self.mLocationCityTo.text=city;
                    placeTo = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
                 }
                 [[NSUserDefaults standardUserDefaults] setObject:lotu forKey:@"longitudeTo"];
                 [[NSUserDefaults standardUserDefaults] setObject:lati forKey:@"latitudeTo"];
             }
             
             
         }
     }];
    
}
- (void)getCoor {
    CGPoint point = mImageFocus.frame.origin;
    point.x = point.x + mImageFocus.frame.size.width / 2;
    point.y = point.y + mImageFocus.frame.size.height;
    if (locationTabPosition == 0) {
        coordinateFrom = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateFrom];
    } else {
        coordinateTo = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateTo];
    }

}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self getCoor];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
        
    }
}
- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated {
    //add gesture to map
    [viewLocationFrom removeGestureRecognizer:gestureFrom];
    [viewLocationTo removeGestureRecognizer:gestureTo];
}
- (IBAction)searchMap:(id)sender {
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewtabBar.frame;
    frame.origin.y=-100;
    self.ViewtabBar.frame=frame;
    [UIView commitAnimations];
    [self.mSearchBar becomeFirstResponder];
//    [self.searchDisplayController setActive:YES animated:YES];
    background.hidden=NO;
//    CGRect frame1=background.frame;
//    frame1.origin.y=65;
//    background.frame=frame1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrDataSearched count];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    MKMapItem *entity = [arrDataSearched objectAtIndex:indexPath.row];
    cell.textLabel.text = entity.placemark.title;
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKMapItem *mapItem = [arrDataSearched objectAtIndex:indexPath.row];
    self.mapview.centerCoordinate = mapItem.placemark.coordinate;
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewtabBar.frame;
    frame.origin.y=0;
    self.ViewtabBar.frame=frame;
    [UIView commitAnimations];
    background.hidden=YES;
    [mTableViewSuggest setBounds:CGRectMake(0,
                                            self.mSearchBar.frame.origin.y + self.mSearchBar.frame.size.height,320,0)];
    [self.view endEditing:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewtabBar.frame;
    frame.origin.y=0;
    self.ViewtabBar.frame=frame;
    [UIView commitAnimations];
    background.hidden=YES;
    [mTableViewSuggest setBounds:CGRectMake(0,
                                            self.mSearchBar.frame.origin.y + self.mSearchBar.frame.size.height,320,0)];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [mTableViewSuggest.layer addAnimation:animation forKey:nil];
    [mTableViewSuggest setHidden:NO];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [mTableViewSuggest.layer addAnimation:animation forKey:nil];
    [mTableViewSuggest setHidden:YES];
    [arrDataSearched removeAllObjects];
    
    [mTableViewSuggest reloadData];
    
    searchBar.text = @"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [arrDataSearched removeAllObjects];
    
    if (searchText ==NULL || [searchText isEqualToString:@""]) {
        
    }
    else{
        if (self.localSearch.searching)
        {
            [self.localSearch cancel];
        }
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        
        request.naturalLanguageQuery = searchText;
        MKCoordinateRegion newRegion;
        NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
        NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
        newRegion.center.latitude = [latitude doubleValue];
        newRegion.center.longitude = [longitude doubleValue];
        newRegion.span.latitudeDelta = 0.112872;
        newRegion.span.longitudeDelta = 0.109863;
        request.region = newRegion;
        MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error)
        {
            if (error != nil)
            {
                NSString *errorStr = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find places"
                                                                message:errorStr
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                [arrDataSearched addObjectsFromArray:[response mapItems]];
                
                CGRect bounds = [mTableViewSuggest bounds];
                self.boundingRegion = response.boundingRegion;
                [mTableViewSuggest setBounds:CGRectMake(bounds.origin.x,
                                                        self.mSearchBar.frame.origin.y + self.mSearchBar.frame.size.height,
                                                        bounds.size.width,
                                                        250)];
                CGRect frame=mTableViewSuggest.frame;
                frame.origin.y=60;
                mTableViewSuggest.frame=frame;
                if (arrDataSearched.count==0) {
                    mTableViewSuggest.hidden=YES;
                }
                else
                    mTableViewSuggest.hidden=NO;
                [mTableViewSuggest reloadData];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        };
        if (self.localSearch != nil)
        {
            self.localSearch = nil;
        }
        self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
        
        [self.localSearch startWithCompletionHandler:completionHandler];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    
}

@end
