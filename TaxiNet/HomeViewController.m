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
@interface HomeViewController () {
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;
    MKPlacemark *placeFrom, *placeTo;
    int locationTabPosition;
    UITapGestureRecognizer *gestureFrom, *gestureTo;
    MKRoute *routeDetails;
    NSMutableArray *arrDataSearched;
    NSInteger selectTo;
    BOOL fromselect;
    AppDelegate*appdelegate;
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
    arrDataSearched = [[NSMutableArray alloc] init];
    
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
    
    gestureTo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(selectLocationTo:)];
    [self.viewLocationTo addGestureRecognizer:gestureTo];
    
    [self selectLocationFrom:gestureFrom];
    [self.viewLocationFrom setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                              green:142.0f/255.0f
                                                               blue:209.0f/255.0f
                                                              alpha:1.0f]];
    
    [self.viewLocationTo setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                            green:142.0f/255.0f
                                                             blue:209.0f/255.0f
                                                            alpha:1.0f]];
    [self.ViewDetail setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                            green:142.0f/255.0f
                                                             blue:209.0f/255.0f
                                                            alpha:1.0f]];
    selectTo=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"ShowViewDetail" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"getRiderInfo" object:nil];
    
    
}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"ShowViewDetail"]) {
        [UIView setAnimationDuration:0.5];
        CGRect frame= mapview.frame;
        frame.size.height=390;
        mapview.frame=frame;
        [UIView commitAnimations];
        [UIView setAnimationDuration:0.5];
        CGRect framedetail= self.ViewDetail.frame;
        framedetail.origin.y=390;
        self.ViewDetail.frame=framedetail;
        [UIView commitAnimations];
    }
    if ([[notification name]isEqualToString:@"getRiderInfo"]) {
        NSLog(@"push :%@",appdelegate.RiderInfo);
        NSString *status=[appdelegate.RiderInfo objectForKey:@"status"];
        if ([status isEqualToString:@"CA"]) {
            [UIView setAnimationDuration:0.5];
            CGRect frame= mapview.frame;
            frame.size.height=390;
            mapview.frame=frame;
            [UIView commitAnimations];
            [UIView setAnimationDuration:0.5];
            CGRect framedetail= self.ViewDetail.frame;
            framedetail.origin.y=390;
            self.ViewDetail.frame=framedetail;
            [UIView commitAnimations];
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Status Request Taxi" message:@"Your request not acepted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
        }
        else if ([status isEqualToString:@"AC"])
        {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Status Request Taxi" message:@"Your request  acepted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
            self.btnWaiting.hidden=NO;
        }
    }
}
- (void)selectLocationFrom:(UITapGestureRecognizer *)recognizer {
    [mImageFocus setImage:[UIImage imageNamed:@"fromMap.png"]];

    if (fromselect==TRUE) {
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
    }

}
- (void)selectLocationTo:(UITapGestureRecognizer *)recognizer {
    [mImageFocus setImage:[UIImage imageNamed:@"toMap.png"]];
    fromselect=TRUE;

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
    JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
    annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
    annotationTo.image = [UIImage imageNamed:@"toMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
    
    
    NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFrom"];
    NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFrom"];
    JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
    annotation.image = [UIImage imageNamed:@"fromMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
}

- (IBAction)waitingTaxi:(id)sender {
}

- (IBAction)BookNow:(id)sender {
    // add anonator map from-to
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
    NSLog(@"distance: %4.0f m",distance);
    [[NSUserDefaults standardUserDefaults] setFloat:distance forKey:@"distance"];
    
    
}

-(void)zoomInToMyLocation
{
    //    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    //    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 21.0018385 ;
    region.center.longitude = 105.80524481;
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [[NSUserDefaults standardUserDefaults] setObject:@"105.80524481" forKey:@"longitudeTo"];
    [[NSUserDefaults standardUserDefaults] setObject:@"21.0018385" forKey:@"latitudeTo"];
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
            framedetail.origin.y=510;
            self.ViewDetail.frame=framedetail;
            [UIView commitAnimations];
            
            CGRect frame= mapview.frame;
            frame.size.height=510;
            mapview.frame=frame;
            [UIView commitAnimations];
            
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
             CLPlacemark *placemark = placemarks[0];
             
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             } else {
                 address = @"Address Not founded";
             }
             if ([placemark.addressDictionary objectForKey:@"SubAdministrativeArea"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"SubAdministrativeArea"];
             else if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"City"];
             else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"Country"];
             else
                 city = @"City Not founded";
             
             if (locationTabPosition == 0) {
                 mLocationFrom.text = address;
                 [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressFrom"];
                 if ([address length]>30) {
                     mLocationFrom.text=[address substringToIndex:[address length] - 27];
                     [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressFrom"];
                 }
                 placeFrom = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
                 [[NSUserDefaults standardUserDefaults] setObject:lotu forKey:@"longitudeFrom"];
                 [[NSUserDefaults standardUserDefaults] setObject:lati forKey:@"latitudeFrom"];
                 
             } else {
                 mLocationTo.text = address;
                 [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressTo"];
                 if ([address length]>30) {
                     mLocationTo.text=[address substringToIndex:[address length] - 27];
                     [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressTo"];
                 }
                 placeTo = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
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
@end
