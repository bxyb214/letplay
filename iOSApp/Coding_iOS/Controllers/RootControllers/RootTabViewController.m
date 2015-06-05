//
//  RootTabViewController.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-29.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "RootTabViewController.h"
#import "Project_RootViewController.h"
#import "MyTask_RootViewController.h"
#import "Tweet_RootViewController.h"
#import "Me_RootViewController.h"
#import "Message_RootViewController.h"
#import "RDVTabBarItem.h"
#import "UnReadManager.h"
#import "BaseNavigationController.h"
#import "AllInvitation_RootViewController.h"
#import "MySentInvitation_RootViewController.h"
#import "AcceptedInvitation_RootViewController.h"
@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Private_M
- (void)setupViewControllers {
//    Project_RootViewController *project = [[Project_RootViewController alloc] init];
//    RAC(project, rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:@[RACObserve([UnReadManager shareManager], project_update_count)]
//                                                             reduce:^id(NSNumber *project_update_count){
//                                                                 return project_update_count.integerValue > 0? kBadgeTipStr : @"";
//                                                             }];
//    UINavigationController *nav_project = [[BaseNavigationController alloc] initWithRootViewController:project];
//    
//    
//    
//    MyTask_RootViewController *mytask = [[MyTask_RootViewController alloc] init];
//    UINavigationController *nav_mytask = [[BaseNavigationController alloc] initWithRootViewController:mytask];
//    
    Tweet_RootViewController *tweet = [[Tweet_RootViewController alloc] init];
    UINavigationController *nav_tweet = [[BaseNavigationController alloc] initWithRootViewController:tweet];
//
//    Message_RootViewController *message = [[Message_RootViewController alloc] init];
//    RAC(message, rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:@[RACObserve([UnReadManager shareManager], messages),
//                                                                      RACObserve([UnReadManager shareManager], notifications)]
//                                                             reduce:^id(NSNumber *messages, NSNumber *notifications){
//                                                                 NSString *badgeTip = @"";
//                                                                 NSNumber *unreadCount = [NSNumber numberWithInteger:messages.integerValue +notifications.integerValue];
//                                                                 if (unreadCount.integerValue > 0) {
//                                                                     if (unreadCount.integerValue > 99) {
//                                                                         badgeTip = @"99+";
//                                                                     }else{
//                                                                         badgeTip = unreadCount.stringValue;
//                                                                     }
//                                                                 }
//                                                                 return badgeTip;
//                                                             }];
//    UINavigationController *nav_message = [[BaseNavigationController alloc] initWithRootViewController:message];
    
    Me_RootViewController *me = [[Me_RootViewController alloc] init];
    me.isRoot = YES;
    UINavigationController *nav_me = [[BaseNavigationController alloc] initWithRootViewController:me];
    

    //======
    AllInvitation_RootViewController *allInvitations = [[AllInvitation_RootViewController alloc] init];
    RAC(allInvitations, rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:@[RACObserve([UnReadManager shareManager], project_update_count)]
                                                                reduce:^id(NSNumber *project_update_count){
                                                                    return project_update_count.integerValue > 0? kBadgeTipStr : @"";
                                                                }];
    UINavigationController *nav_allInvitations = [[BaseNavigationController alloc] initWithRootViewController:allInvitations];
   
    MySentInvitation_RootViewController *mysentInvitations = [[MySentInvitation_RootViewController alloc] init];
    UINavigationController *nav_mysentInvitations = [[BaseNavigationController alloc] initWithRootViewController:mysentInvitations];
    
    
    AcceptedInvitation_RootViewController *acceptedInvitation = [[AcceptedInvitation_RootViewController alloc] init];
    UINavigationController *nav_acceptedInvitation = [[BaseNavigationController alloc] initWithRootViewController:acceptedInvitation];
    
    
    //=====
    
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController *nav_vc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
   // [self setViewControllers:@[nav_project2, nav_allInvitations, nav_mysentInvitations, nav_acceptedInvitation, nav_me]];
    
     [self setViewControllers:@[nav_allInvitations, nav_mysentInvitations, nav_acceptedInvitation, nav_me]];
    
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    //NSArray *tabBarItemImages = @[@"project", @"task", @"tweet", @"privatemessage", @"me"];
    //NSArray *tabBarItemTitles = @[@"我的项目", @"All Invitations", @"Sent Invitations", @"Accepted Invitations", @"Me"];
    
    NSArray *tabBarItemImages = @[ @"task", @"tweet", @"privatemessage", @"me"];
    NSArray *tabBarItemTitles = @[ @"All Invitations", @"Sent", @"Accepted", @"Me"];
    
    
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController == viewController) {        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)viewController;
            if (nav.topViewController == nav.viewControllers[0]) {
                BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
#pragma clang diagnostic ignored "-Warc-performSelector"
                if ([rootVC respondsToSelector:@selector(tabBarItemClicked)]) {
                    [rootVC performSelector:@selector(tabBarItemClicked)];
                }
            }
        }
    }
    return YES;
}
@end
