//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "HomeViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "NavigationController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "ShowMyPromotionTrip.h"
#import "LoginViewController.h"
#import "SupportViewController.h"
#import "HistoryViewController.h"
#import "AboutUsViewController.h"

@interface DEMOMenuViewController (){
    AppDelegate*appDelegate;
    UIImageView *imageView;
    UILabel *label;
    UIStoryboard *mainStoryboard;
    UIStoryboard *mainStoryboard1;
    UIStoryboard *menuStoryboard;
    NavigationController *navigationController;
    
}

@end

@implementation DEMOMenuViewController
@synthesize myPromotionTripRider;
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainStoryboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    menuStoryboard = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];
    navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    navigationController.viewControllers = @[controller];

    [navigationController setViewControllers:@[controller]];
   // appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   // NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"10487216_687099491374102_218448137921331276_n.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text = @"RIDER APPLICATION";//[userDF objectForKey:@"RiderFullName"];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
       
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate
// set data my promotiin trip rider
-(void)setDataArray{
   // appDelegate.myPromotionTripArr = (NSMutableArray*)self.myPromotionTripRider;
    ///NSLog(@"AAA%@",appDelegate.myPromotionTripArr);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

  
   
    if (indexPath.row == 0) {
        HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 1)
    {
        ProfileViewController *controller = (ProfileViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 2)
    {
        HistoryViewController  *controller = (HistoryViewController *)[menuStoryboard instantiateViewControllerWithIdentifier: @"HistoryViewController"];
        [navigationController pushViewController:controller animated:YES];

    
    }
    else if (indexPath.row == 3)
    {
        //[unity getMyPromotionTrip:@"2" owner:self];
        ShowMyPromotionTrip *controller = (ShowMyPromotionTrip *)[mainStoryboard instantiateViewControllerWithIdentifier: @"ShowMyPromotionTrip"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 4)
    {
        AboutUsViewController  *controller = (AboutUsViewController *)[menuStoryboard instantiateViewControllerWithIdentifier: @"AboutUsViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 5)
    {
        SupportViewController  *controller = (SupportViewController *)[menuStoryboard instantiateViewControllerWithIdentifier: @"SupportViewController"];
        [navigationController pushViewController:controller animated:YES];


    }
    else if (indexPath.row == 6)
    {
        LoginViewController  *controller = (LoginViewController *)[mainStoryboard1 instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [navigationController pushViewController:controller animated:YES];
        NSString* riderId = [[NSUserDefaults standardUserDefaults] stringForKey:@"riderId"];
        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = [defs dictionaryRepresentation];
        for (id key in dict) {
            [defs removeObjectForKey:key];
        }
        [defs synchronize];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [unity LogOut:riderId];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        NSArray *titles = @[@"Home", @"Profile", @"My Trips",@"My Promotion Trips", @"About Us",@"Support",@"Logout"];
        cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}
 
@end
