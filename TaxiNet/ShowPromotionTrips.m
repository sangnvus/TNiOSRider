//
//  ShowPromotionTrips.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/13/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ShowPromotionTrips.h"
#import "unity.h"
#import "CustomCellPromotionTableViewCell.h"
#import "UserInfo.h"

@implementation ShowPromotionTrips
{
    NSArray *recipes;
    UserInfo *userData;
    
}

-(void) viewDidLoad{
    [super viewDidLoad];
    recipes = [NSArray arrayWithObjects:@"TaxiNet company will 1 2 3 3 3 3 3 3 3 3 3 and free for all member ", @"Dino company will2 2 2 2 2 2 2 2 2 2 free for all member at weeken", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CustomPromotionCell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    CustomCellPromotionTableViewCell *cell = (CustomCellPromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomPromotionCell"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.descriptionPro.text = [recipes objectAtIndex:indexPath.row];
    //cell.logoImage.image  = [UIImage imageNamed:[t]]
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (IBAction)backBtn:(id)sender {
}
@end
