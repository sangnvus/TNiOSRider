//
//  ShowMyPromotionTrip.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ShowMyPromotionTrip.h"
#import "CustomMyPromotionTrip.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AddTripViewController.h"
@interface ShowMyPromotionTrip ()
{
    AppDelegate *appDelegate;
    NSArray *dataArr;
    NSArray *driverArr;
    UIStoryboard *homeStoryboard;
    //UIStoryboard *findPromotionStoryboard;
    
}

@end

@implementation ShowMyPromotionTrip
@synthesize myPromotionTrips;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [unity getMyPromotionTrip:[user objectForKey:@"riderId"] owner:self];
    // Do any additional setup after loading the view.
    //set storyboard
    homeStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    dataArr = [[NSArray alloc] init];
    driverArr = [[NSArray alloc]init];
    // set data to nsmutabledictionary
    appDelegate = (AppDelegate * )[[UIApplication sharedApplication] delegate];
    
    // set color
//    [UIColor colorWithRed:1 green:0.251 blue:0 alpha:1] #ff4000
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [self.nextToFindPro setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
}
-(void)showdata
{
        [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myPromotionTrips count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataArr = [self.myPromotionTrips objectAtIndex:indexPath.row];
    driverArr = [dataArr valueForKey:@"driver"];
    static NSString *simpleTableIdentifier = @"CustomMyPromotion";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     CustomMyPromotionTrip *cell = (CustomMyPromotionTrip *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    [cell.labelView setBackgroundColor:[UIColor colorWithRed:0.839 green:0.129 blue:0.129 alpha:1]];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomMyPromotion"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if ([[dataArr valueForKey:@"status"] isEqualToString:@"AC" ]) {
        cell.statusLb.text = @"Registed";//[dataArr objectForKey:@"status"];
    }
    cell.dateTimeLb.text = [dataArr valueForKey:@"time"];
    
    cell.fromLb.text = [dataArr valueForKey:@"fromAddress"];
    cell.toLb.text = [dataArr valueForKey:@"toAddress"];
    cell.numberOfSeats.text = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"noOfSeat"]];
    cell.priceLb.text = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"fee"]];
    cell.driverLb.text = [NSString stringWithFormat:@"%@ %@",[driverArr valueForKey:@"firstName"],[driverArr valueForKey:@"lastName"]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 157;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// catch event swipe
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    //[self.tableView removeObjectAtIndex:indexPath.row];
}


- (IBAction)backBtn:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)findPromotion:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    AddTripViewController *controller = (AddTripViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AddTripViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
