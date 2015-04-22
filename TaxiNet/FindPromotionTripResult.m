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
@synthesize proArray,driverArray;
@synthesize nOfS;
-(AppDelegate *)appdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // init count
    count = 0;
    flag = 9999;
    checkRegister = [[NSArray alloc]init];
    
    // init delegate
    appDelegate=[self appdelegate];

    NSLog(@"USERDATA:%@",appDelegate.yoursefl);
    NSLog(@"PROMOTION DATA %@:",appDelegate.promotionDataArray);
    
    // set color
    [customTrip.labelView setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appDelegate.promotionDataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    [customTrip.labelView setBackgroundColor:[UIColor colorWithRed:0.875 green:0.89 blue:0.933 alpha:1]];
    
    static NSString *simpleTableIdentifier = @"CustomMyPromotion";
    
    proArray = [appDelegate.promotionDataArray objectAtIndex:indexPath.row];
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
    //priceFee = *(double)[proArray valueForKey:@"fee"];
    // feePrice = [proArray valueForKey:@"fee"];
//    numOfSeats = [proArray valueForKey:@"capacity"]; //eo hieu loi gi
    
    driverName = [driverArray valueForKey:@"firstName"];
    
    fromAddressShow = [NSString stringWithFormat:@"%@, %@",fromAddress,fromCity];
    toAddressShow = [NSString stringWithFormat:@"%@, %@", toAddress, toCity];
    
//    status is null
//    cell.statusLb.text = [proArray valueForKey:@"status"];
    //set data if status is null
    
    //[appDelegate.promotionDataArray setValue:@"Register" forKey:@"status"];
    
    cell.statusLb.text = @"Register";/*[appDelegate.promotionDataArray valueForKey:@"status"];*/
    cell.dateTimeLb.text = [proArray valueForKey:@"time"];
    cell.fromLb.text = fromAddressShow;
    cell.toLb.text = toAddressShow;
    cell.numberOfSeats.text = [NSString stringWithFormat:@"%@",[proArray valueForKey:@"capacity"]];
    cell.priceLb.text = [NSString stringWithFormat:@"%@",[proArray valueForKey:@"fee"]];
    cell.driverLb.text = driverName;
    [cell isHidden];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    RegisterPromotionTrip *controller = (RegisterPromotionTrip*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"RegisterPromotionTrip"];
    [self.navigationController pushViewController:controller animated:YES];


}
@end
