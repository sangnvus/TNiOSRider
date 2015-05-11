//
//  FindPromotionTripResult.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/15/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "FindPromotionTripResult.h"
#import "FindPromotionTrip.h"
#import "AppDelegate.h"
#import "CustomMyPromotionTrip.h"
#import "unity.h"
#import "RegisterPromotionTrip.h"

@interface FindPromotionTripResult ()


@end

@implementation FindPromotionTripResult{
    
    UIStoryboard *homeStoryBoard;
    AppDelegate *appDelegate;
    CustomMyPromotionTrip *customTrip;
    
//    NSArray *proArray;
//    NSArray *driverArray;
    //khai bao data send
    NSString *proTripId;
    NSString *riderId;

    NSString *fromCity;
    NSString *fromAddress;
    NSString *toAddress;
    NSString *toCity;
    //NSInteger numOfSeats;
    double feePrice;
    // khai bao data show to cell
    NSString *dateTime;
    NSString *status;
    NSString *fromAddressShow;
    NSString *toAddressShow;
    NSString *numberOfSeats;
    double *priceShow;
    NSString *numberPerson;
    
    NSString *driverName;
    int count;
    NSInteger flag;
    NSMutableArray *checkRegister;
    
}
@synthesize proArray,driverArray,promotionTripResult;
@synthesize nOfS;
-(AppDelegate *)appdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *promotionInfo = [NSUserDefaults standardUserDefaults];
    NSString *fromLatitude = [promotionInfo objectForKey:@"registerProFromLat"];
    NSString *fromLongitude = [promotionInfo objectForKey:@"registerProFromLong"];
    NSString *toLatitude = [promotionInfo objectForKey:@"registerProToLat"];
    NSString *toLongitude = [promotionInfo objectForKey:@"registerProToLong"];
    NSString *noOfSeats = [promotionInfo objectForKey:@"noOfSeats"];
    NSString *startTime = [promotionInfo objectForKey:@"dataTime"];
    [unity findPromotionTrips:fromLatitude andfromLongitude:fromLongitude withToLatitude:toLatitude andToLongitude:toLongitude numberOfSeats:noOfSeats startTime:startTime  owner:self];
    // init array
    promotionTripResult = [[NSArray alloc]init];
    driverArray = [[NSArray alloc]init];
    
    // init count
    count = 0;
    flag = 9999;
    
    // init delegate
    appDelegate=[self appdelegate];
    
    // set color
    //    [UIColor colorWithRed:1 green:0.251 blue:0 alpha:1] orange 1
    //[customTrip.labelView setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backPromotionBtn:(id)sender {
    homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    FindPromotionTrip *controller = (FindPromotionTrip*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"FindPromotionTrip"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)menuBtn:(id)sender {
    
}

-(void)checkAndSetData{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return appDelegate.promotionDataArray.count;
    return [promotionTripResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *startDateTime;
    NSString *priceToShow;
    [customTrip.labelView setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    
    static NSString *simpleTableIdentifier = @"CustomMyPromotion";
    
    proArray = [promotionTripResult objectAtIndex:indexPath.row];
    driverArray = [proArray valueForKey:@"driver"];
    CustomMyPromotionTrip *cell = (CustomMyPromotionTrip *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomMyPromotion"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    //get data from Array
    fromAddress = [proArray valueForKey:@"fromAddress"];
    fromCity = [proArray valueForKey:@"fromCity"];
    toAddress = [proArray valueForKey:@"toAddress"];
    toCity = [proArray valueForKey:@"toCity"];
    startDateTime = [proArray valueForKey:@"time"];
    priceToShow = [NSString stringWithFormat:@"%@ /person",[proArray valueForKey:@"fee"]];
    
    driverName = [NSString stringWithFormat:@"%@ %@",[driverArray valueForKey:@"firstName"],[driverArray valueForKey:@"lastName"]];
    
    fromAddressShow = [NSString stringWithFormat:@"%@, %@",fromAddress,fromCity];
    toAddressShow = [NSString stringWithFormat:@"%@, %@", toAddress, toCity];

    
    cell.statusLb.text = @"Register";/*[appDelegate.promotionDataArray valueForKey:@"status"];*/
    cell.dateTimeLb.text = startDateTime;
    cell.fromLb.text = fromAddressShow;
    cell.toLb.text = toAddressShow;
    cell.numberOfSeats.text = [NSString stringWithFormat:@"%@",[proArray valueForKey:@"capacity"]];
    cell.priceLb.text = priceToShow;
    cell.driverLb.text = driverName;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSArray *arrFlag = [[NSArray alloc]init];
     arrFlag = [promotionTripResult objectAtIndex:indexPath.row];

//    if (indexPath != 0) {
    //NSLog(@"arr flag  gg g g :%@",arrFlag);
    //if (indexPath != 0) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        [user setObject:[arrFlag valueForKey:@"fromCity"] forKey:@"fromCityShow1"];
        [user setObject:[arrFlag valueForKey:@"toCity"] forKey:@"toCityShow1"];
        [user setObject:[arrFlag valueForKey:@"id"] forKey:@"promotionTripId"];

    
    homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    RegisterPromotionTrip *controller = (RegisterPromotionTrip*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"RegisterPromotionTrip"];
    [self.navigationController pushViewController:controller animated:YES];


}
@end
