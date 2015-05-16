//
//  TripInfoViewController.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/16/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "TripInfoViewController.h"
#import "AppDelegate.h"
#import "HistoryViewController.h"

@interface TripInfoViewController ()

@end

@implementation TripInfoViewController
{
    AppDelegate *appDelegate;
    NSArray *driverArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    driverArray = [appDelegate.tripInfoArray valueForKey:@"driver"];
    
    self.driverName.text = [NSString stringWithFormat:@"%@ %@",[driverArray valueForKey:@"firstName"],[driverArray valueForKey:@"lastName"]];
    self.phoneNumber.text = [driverArray valueForKey:@"phoneNumber"];
    self.fromAddress.text = [appDelegate.tripInfoArray valueForKey:@"fromAddress"];
    self.toAddress.text = [appDelegate.tripInfoArray valueForKey:@"toAddress"];
    self.startDate.text = [appDelegate.tripInfoArray valueForKey:@"startTime"];
    self.endDate.text = [appDelegate.tripInfoArray valueForKey:@"endTime"];
    self.costLb.text = [NSString stringWithFormat:@"%@",[appDelegate.tripInfoArray valueForKey:@"fee"]];
    self.paymentMethod.text = [appDelegate.tripInfoArray valueForKey:@"paymentType"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showData:(NSArray *)data{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doBack:(id)sender {
    UIStoryboard *otherStory = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];
    HistoryViewController *myTrip = (HistoryViewController*)[otherStory instantiateViewControllerWithIdentifier:@"HistoryViewController"];
    [self.navigationController pushViewController:myTrip animated:YES];
}

- (IBAction)callDriver:(id)sender {
    
    NSString *phoneNo = [@"tel://" stringByAppendingString:[self.phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNo]];
}
@end
