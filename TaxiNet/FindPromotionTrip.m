//
//  FindPromotionTrip.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "FindPromotionTrip.h"
#import "ShowMyPromotionTrip.h"
#import "unity.h"
#import "REFrostedViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FindPromotionTripResult.h"

@interface FindPromotionTrip ()

@end

@implementation FindPromotionTrip{
    UIStoryboard *homeStoryboard;
    
    double fromLatitude;
    double fromLongitude;
    double toLatitude;
    double toLongitude;
    UITapGestureRecognizer *gestureFrom, *gestureTo, *gestureDate;
    MKPlacemark *placeFrom, *placeTo;
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;
    int locationTabPosition;
    AppDelegate *appDelegate;
    FindPromotionTripResult *findProResult;
    UIDatePicker *datePicker;
    UILabel *dateLabel;
    
}
@synthesize fromAddress, toAddress, noOfSeatsField, pointPick, mapViewPro,fromCityField,toCityField;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    // delegate
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //set anchor point focus point
    pointPick.layer.anchorPoint = CGPointMake(0.5, 1.0);
    mapViewPro.delegate = self;
    // set mapview
    
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:1];
    
    gestureFrom = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectLocationFrom:)];
    [self.viewLocationFrom addGestureRecognizer:gestureFrom];
    
    gestureTo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(selectLocationTo:)];
    [self.viewLocationTo addGestureRecognizer:gestureTo];
    // set current date time
    gestureDate = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectDateTime:)];
    [self.viewDateTime addGestureRecognizer:gestureDate];
    //[self selectDateTime:gestureDate];
    
    [self selectLocationFrom:gestureFrom];
    //
    //set color for app
    [self.viewDetails setBackgroundColor:[UIColor colorWithRed:1 green:0.922 blue:0.898 alpha:1]];
    ///*#3b5998 mau 1*/ [UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1] /*#3b5998*/ blue 1
//    [UIColor colorWithRed:1 green:0.251 blue:0 alpha:1] orange 1
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [self.findBtn setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    ///*#8b9dc3 mau 2*/ [UIColor colorWithRed:0.545 green:0.616 blue:0.765 alpha:1] /*#8b9dc3*/ blue 2
//    [UIColor colorWithRed:1 green:0.922 blue:0.898 alpha:1] /*#ffebe5*/ orange 2
    [self.viewLocationFrom setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    [self.viewLocationTo setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    
    //[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1] /*#dfe3ee*/ mau 3 blue 3
    
    //[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1] /*#f7f7f7*/ mau 4 blue 4
    [self.viewNumber setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    
    // hide keyboard when tap other arena
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)hideKeyBoard {
    [self.fromAddress resignFirstResponder];
    [self.toAddress resignFirstResponder];
    [self.noOfSeatsField resignFirstResponder];
    [self.toCityField resignFirstResponder];
    [self.fromCityField resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)backBtn:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (IBAction)getCurrentLocation:(id)sender {
    
    
}
-(void)checkAndSetData{
    //appdelegate.promotionDataDe = (NSMutableDictionary*)self.promotionData;
    NSUserDefaults *userdef = [NSUserDefaults standardUserDefaults];
    [userdef setObject:noOfSeatsField.text forKey:@"noOfSeatsField"];

    appDelegate.promotionDataArray = (NSMutableArray*)self.promotionDataArr;
    NSLog(@"PRO DATA: %@",self.promotionDataArr);
    

   //NSLog(@"data test:%@", appDelegate.promotionDataArray);
//    NSInteger count;
//    count = self.promotionDataArr.count;
//    NSArray *arrr = [self.promotionDataArr objectAtIndex:0];
//    NSArray *driver = [arrr valueForKey:@"driver"];
//    NSString *firstNamea = [driver valueForKey:@"firstName"];
//    NSLog(@"NANANAN: %@",firstNamea);
    

}
- (IBAction)findPromotion:(id)sender {
    if (self.fromAddress==nil|| [self.fromAddress.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please pick your start place",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if (self.toAddress==nil|| [self.toAddress.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please pick your stop place",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if (self.noOfSeatsField==nil|| [self.noOfSeatsField.text isEqualToString:@""]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter number of seats",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else{
        NSLog(@"Longiude Lat:%f %f %f %f",fromLongitude, fromLatitude, toLongitude, toLatitude);
        //store data
        NSUserDefaults *registerProData = [NSUserDefaults standardUserDefaults];
        [registerProData setObject:[NSString stringWithFormat:@"%@",fromAddress.text] forKey:@"registerProFromAdd"];
        [registerProData setObject:[NSString stringWithFormat:@"%f",fromLatitude] forKey:@"registerProFromLat"];
        [registerProData setObject:[NSString stringWithFormat:@"%f",fromLongitude] forKey:@"registerProFromLong"];
        [registerProData setObject:[NSString stringWithFormat:@"%@",fromCityField.text] forKey:@"registerProFromCity"];
        
        [registerProData setObject:[NSString stringWithFormat:@"%@",toAddress.text] forKey:@"registerProToAdd"];
        [registerProData setObject:[NSString stringWithFormat:@"%f",toLatitude] forKey:@"registerProToLat"];
        [registerProData setObject:[NSString stringWithFormat:@"%f",toLongitude] forKey:@"registerProToLong"];
        [registerProData setObject:[NSString stringWithFormat:@"%@",toCityField.text] forKey:@"registerProToCity"];
        
        [registerProData setObject:self.noOfSeatsField.text forKey:@"noOfSeats"];
        [registerProData setObject:@"2015-05-17 12:00:00" forKey:@"dataTime"];
        
        
        // goto next screen
        homeStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
        FindPromotionTripResult *controller = (FindPromotionTripResult*)[homeStoryboard instantiateViewControllerWithIdentifier:@"FindPromotionTripResult"];
        [self.navigationController pushViewController:controller animated:YES];

        //NSLog(@"%@")
    }
    
}

- (void) getReverseGeocode:(CLLocationCoordinate2D) coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocationCoordinate2D myCoOrdinate;
    
    myCoOrdinate.latitude = coordinate.latitude;
    myCoOrdinate.longitude = coordinate.longitude;
    
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
             NSString *address1 = @"";
             NSString *distric = @"";
             NSString *city = @"";
             CLPlacemark *placemark = placemarks[0];
             
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address1 = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"]componentsJoinedByString:@", "];
             } else {
                 address1 = @"Address Not founded";
             }
             if ([placemark.addressDictionary objectForKey:@"SubAdministrativeArea"] != NULL)
                 distric = [placemark.addressDictionary objectForKey:@"SubAdministrativeArea"];
             else if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 distric = [placemark.addressDictionary objectForKey:@"City"];
             else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                 distric = [placemark.addressDictionary objectForKey:@"Country"];
             else{
                 distric = @"City Not founded";
             }
             //get city
             if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"City"];
             else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"Country"];
             else{
                 city = @"City Not founded";
             }
             address = [NSString stringWithFormat:@"%@, %@",address1,distric];
             
             if (locationTabPosition == 0) {
                 fromAddress.text = address;
                 fromLatitude = myCoOrdinate.latitude;
                 fromLongitude = myCoOrdinate.longitude;
                 fromCityField.text = city;
                 //NSLog(@"Latitude: %f",myCoOrdinate.latitude);
                 //NSLog(@"Longitude: %f",myCoOrdinate.longitude);
//                 if ([address length]>30) {
//                     fromAddress.text=[address substringToIndex:[address length] - 27];
//                 }
                 placeFrom = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
             } else if(locationTabPosition==1){
                 toAddress.text = address;
                 toCityField.text = city;
                 toLatitude = myCoOrdinate.latitude;
                 toLongitude = myCoOrdinate.longitude;
//                 if ([address length]>30) {
//                     toAddress.text=[address substringToIndex:[address length] - 27];
//                 }
                 placeTo = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
             }
             if(locationTabPosition==2){
                     self.viewDateTime.hidden = NO;
                     NSLocale *usLocale = [[NSLocale alloc]
                                           initWithLocaleIdentifier:@"en_US"];
                 
                     NSDate *pickerDate = [_dateTime date];
                     NSString *selectionString = [[NSString alloc]
                                                  initWithFormat:@"%@",
                                                  [pickerDate descriptionWithLocale:usLocale]];
                     _dateTimeLb.text = selectionString;
             }
             
             
         }
     }];
    
}
- (void)getCoor {
    CGPoint point = pointPick.frame.origin;
    point.x = point.x + pointPick.frame.size.width / 2;
    point.y = point.y + pointPick.frame.size.height;
    if (locationTabPosition == 0) {
        coordinateFrom = [mapViewPro convertPoint:point toCoordinateFromView:mapViewPro];
        
        [self getReverseGeocode:coordinateFrom];
    } else if(locationTabPosition == 1){
        coordinateTo = [mapViewPro convertPoint:point toCoordinateFromView:mapViewPro];
        [self getReverseGeocode:coordinateTo];
    }
}
- (void)selectLocationFrom:(UITapGestureRecognizer *)recognizer {
    //    [viewLocationFrom setBackgroundColor:[UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f]];
    //    [viewLocationTo setBackgroundColor:[UIColor whiteColor]];
    //    [mLocationFrom setTextColor:[UIColor whiteColor]];
    //    [mLocationTo setTextColor:[UIColor blackColor]];
    locationTabPosition = 0;
}


- (void)selectLocationTo:(UITapGestureRecognizer *)recognizer {
    //    [viewLocationTo setBackgroundColor:[UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f]];
    //    [viewLocationFrom setBackgroundColor:[UIColor whiteColor]];
    //    [mLocationTo setTextColor:[UIColor whiteColor]];
    //    [mLocationFrom setTextColor:[UIColor blackColor]];
    locationTabPosition = 1;
}
- (void)selectDateTime:(UITapGestureRecognizer *)recognizer {
    locationTabPosition = 2;
    //    self.viewDateTime.hidden = NO;
    //    NSLocale *usLocale = [[NSLocale alloc]
    //                          initWithLocaleIdentifier:@"en_US"];
    //
    //    NSDate *pickerDate = [_dateTime date];
    //    NSString *selectionString = [[NSString alloc]
    //                                 initWithFormat:@"%@",
    //                                 [pickerDate descriptionWithLocale:usLocale]];
    //    _dateTimeLb.text = selectionString;
}

- (void)viewDidDisappear:(BOOL)animated {
    //add gesture to map
    [self.viewLocationFrom removeGestureRecognizer:gestureFrom];
    [self.viewLocationTo removeGestureRecognizer:gestureTo];
    [self.viewDateTime removeGestureRecognizer:gestureDate];
    
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self getCoor];
}
-(void)zoomInToMyLocation
{
    //    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    //    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 21.0018385 ;
    region.center.longitude = 105.80524481;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [self.mapViewPro setRegion:region animated:YES];
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
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapViewPro dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
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
- (NSArray *)annotations {
    
    // Empire State Building
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"pinMap.png"];
    empire.coordinate = CLLocationCoordinate2DMake(21.0016279f, 105.8049829f);
    empire.disclosureBlock =  ^{
        [UIView animateWithDuration:1
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             CGRect f = self.viewDetails.frame;
                             f.origin.y = 368; // new y
                             self.viewDetails.frame = f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    };
    
    JPSThumbnail *empire2 = [[JPSThumbnail alloc] init];
    empire2.image = [UIImage imageNamed:@"pinMap.png"];
    empire2.coordinate = CLLocationCoordinate2DMake(21.0036279f, 105.8049829f);
    empire2.disclosureBlock =  ^{
        [UIView animateWithDuration:1
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             CGRect f = self.viewDetails.frame;
                             f.origin.y = 368; // new y
                             self.viewDetails.frame = f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    };
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire],[JPSThumbnailAnnotation annotationWithThumbnail:empire2]];
}

@end
