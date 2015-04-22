//
//  CustomCellPromotionTableViewCell.h
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 4/13/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellPromotionTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *descriptionPro;
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
- (IBAction)detailsBtn:(id)sender;



@end
