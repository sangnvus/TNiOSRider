//
//  HistoryViewController.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/5/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "HistoryViewController.h"
#import "REFrostedViewController.h"
#import "CustomHistoryTableViewCell.h"
#import "unity.h"
#import "TripInfoViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
{
    NSArray *dataArr;
    NSArray *driverArr;
    AppDelegate *appDelegate;
}
@synthesize myHistoryTrips;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [unity getTripHistoryWithRiderId:[user objectForKey:@"riderId"] owner:self];
    // init array
    dataArr = [[NSArray alloc] init];
    driverArr = [[NSArray alloc]init];
    
    //set bar color
    [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
}

-(void)showResponseData{
    
    [self.tableView reloadData];
    
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSLog(@"COUNT : %d",self.myHistoryTrips.count);
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.myHistoryTrips count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    dataArr = [self.myHistoryTrips objectAtIndex:indexPath.row];
    driverArr = [dataArr valueForKey:@"driver"];
    static NSString *simpleTableIdentifier = @"CustomHistoryCell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    CustomHistoryTableViewCell *cell = (CustomHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //[cell.labelView setBackgroundColor:[UIColor colorWithRed:0.839 green:0.129 blue:0.129 alpha:1]];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomHistoryCell"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.dateTimeLb.text = [dataArr valueForKey:@"endTime"];
    
    cell.fromAddress.text = [dataArr valueForKey:@"fromAddress"];
    cell.toAddress.text = [dataArr valueForKey:@"toAddress"];
    cell.driverName.text = [NSString stringWithFormat:@"%@ %@",[driverArr valueForKey:@"firstName"],[driverArr valueForKey:@"lastName"]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91;
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
// catch event swipe
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TripInfoViewController *tripDetails;
    dataArr = [self.myHistoryTrips objectAtIndex:indexPath.row];
    appDelegate.tripInfoArray = (NSMutableArray*)dataArr;
   // NSLog(@"DELEGATE TRIP:  %@",appDelegate.tripInfoArray);
    [tripDetails showData:appDelegate.tripInfoArray];
    
    if (!([dataArr count]==0)) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];
        TripInfoViewController *controller = (TripInfoViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"TripInfoViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
