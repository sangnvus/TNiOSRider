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
#import "FindPromotionTrip.h"

@interface ShowMyPromotionTrip ()
{
    AppDelegate *appDelegate;
    NSArray *objData;
    NSArray *dataArr;
    NSArray *keyArr;
    NSDictionary *data;
    UIStoryboard *homeStoryboard;
    //UIStoryboard *findPromotionStoryboard;
    
}

@end

@implementation ShowMyPromotionTrip

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set storyboard
    homeStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    // set data to nsmutabledictionary
    appDelegate = (AppDelegate * )[[UIApplication sharedApplication] delegate];
//    appDelegate.promotionData =(NSMutableDictionary*) self.promotionData;
//    NSLog(@"FROM ADD:%@",[appDelegate.promotionData objectForKey:@"fromAddress"]);
    
    dataArr = [NSArray arrayWithObjects:@"10:10 Date: 10/10/2015 ", @"Regitered",@"Cau giay",@"My dinh",@"2",@"10000",@"Dino", nil];
    keyArr  = [NSArray arrayWithObjects:@"datetime",@"status",@"from",@"to",@"numberofseat",@"price",@"driver", nil];
    data = [NSDictionary dictionaryWithObjects:dataArr forKeys:keyArr];
    objData = [[NSArray alloc]initWithObjects:data, nil];
    
    
    // set color
    [self.bannerView setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];
    [self.nextToFindPro setBackgroundColor:[UIColor colorWithRed:0.231 green:0.349 blue:0.596 alpha:1]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [objData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CustomMyPromotion";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     CustomMyPromotionTrip *cell = (CustomMyPromotionTrip *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomMyPromotion"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.dateTimeLb.text = [data objectForKey:@"datetime"];
    cell.statusLb.text = [data objectForKey:@"status"];
    cell.fromLb.text = [data objectForKey:@"from"];
    cell.toLb.text = [data objectForKey:@"to"];
    cell.numberOfSeats.text = [data objectForKey:@"numberofseat"];
    cell.priceLb.text = [data objectForKey:@"price"];
    cell.driverLb.text = [data objectForKey:@"driver"];
    
    //cell.logoImage.image  = [UIImage imageNamed:[t]]
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    HomeViewController *viewcontroller = [homeStoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (IBAction)findPromotion:(id)sender {
    FindPromotionTrip *viewcontroller = [homeStoryboard instantiateViewControllerWithIdentifier:@"FindPromotionTrip"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
@end
