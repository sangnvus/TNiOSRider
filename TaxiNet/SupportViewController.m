//
//  SupportViewController.m
//  TaxiNet
//
//  Created by Nguyen Hoai Nam on 5/5/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "SupportViewController.h"
#import "REFrostedViewController.h"

@interface SupportViewController ()

@end



@implementation SupportViewController

@synthesize viewBar,viewEmailSupport,viewTel,phoneNumberSupport;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1] /*#feefe7*/
    [viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    
    
    [viewEmailSupport setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];
    [viewTel setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];
   
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapRecognizer];
}
-(void)hideKeyBoard{
    [self.subjectField resignFirstResponder];
    [self.contentField resignFirstResponder];
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

- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
    
    
}
- (IBAction)sendReport:(id)sender {

    
}

- (IBAction)callToSupport:(id)sender {
    // get string number phone with no whitespace
    NSString *phoneNumber = [@"tel://" stringByAppendingString:[phoneNumberSupport.text stringByReplacingOccurrencesOfString:@" " withString:@""]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}
@end
