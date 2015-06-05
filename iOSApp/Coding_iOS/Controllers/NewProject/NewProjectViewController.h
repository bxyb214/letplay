//
//  NewProjectViewController.h
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "Invitation.h"
#import <CoreLocation/CoreLocation.h>

@interface NewProjectViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIImageView *projectImageView;
@property (strong, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *projectTypeLabel;
@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *descTextView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *lines;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *gisLocation;
@property (nonatomic, strong) Invitation *invitation;
@property (weak, nonatomic) IBOutlet UITextField *startTime;

@property (weak, nonatomic) IBOutlet UITextField *endTime;
@end
