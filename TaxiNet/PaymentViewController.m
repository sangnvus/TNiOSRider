//
//  PaymentViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 5/12/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "PaymentViewController.h"
#import "AppDelegate.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController
{
    AppDelegate*appdelegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.name.text=[appdelegate.dataDriver objectForKey:@"lastName"];
    self.phone.text=[appdelegate.dataDriver objectForKey:@"phoneNumber"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"paymentdetail" object:nil];
    self.price.text=[appdelegate.RiderInfo objectForKey:@"fee"];
    self.distance.text=[appdelegate.RiderInfo objectForKey:@"distance"];
}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"paymentdetail"]) {
        [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hidenGrayView" object:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowViewDetail" object:self];
            
        }];
    }
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

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:[self.phone.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
- (IBAction)done:(id)sender {
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hidenGrayView" object:self];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowViewDetail" object:self];
        
    }];
}
@end
