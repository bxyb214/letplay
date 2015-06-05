//
//  NewProjectViewController.m
//  Coding_iOS
//
//  Created by isaced on 15/3/30.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "NewProjectViewController.h"
#import "NewProjectTypeViewController.h"
#import "Coding_NetAPIManager.h"
#import "UIImageView+WebCache.h"
#import "NProjectViewController.h"
#import <RegexKitLite/RegexKitLite.h>
#import "RDVTabBarController.h"


@interface NewProjectViewController ()<NewProjectTypeDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, assign) NewProjectType projectType;
@property (nonatomic, strong) UIBarButtonItem *submitButtonItem;
@property (nonatomic, strong) UIBarButtonItem *acceptButtonItem;
@property (nonatomic, strong) UIImage *projectIconImage;


@end

@implementation NewProjectViewController

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    if (self.invitation != nil) {
        self.projectNameTextField.text = self.invitation.title;
        self.descTextView.text = self.invitation.description_mine;
        self.location.text = self.invitation.location;
        self.age.text = @"5";
        self.gender.text = @"Boys and Girls";
        self.title = @"Details";
        
        NSDateFormatter *dateFormat = [ [NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate *startdate = [dateFormat dateFromString:self.invitation.start_time];
        
        [dateFormat setDateFormat:@"MMMM dd, yyyy hh:mm a"];
        self.startTime.text = [dateFormat stringFromDate:startdate];
         [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate *enddate = [dateFormat dateFromString:self.invitation.start_time];
        
        [dateFormat setDateFormat:@"MMMM dd, yyyy hh:mm a"];
        self.endTime.text = [dateFormat stringFromDate:enddate];
        

    } else {
        self.title = @"Send Invitation";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configLocationManager];
    //
    for (NSLayoutConstraint *cons in self.lines) {
        cons.constant = 0.5;
    }
    
    //
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setSeparatorColor:[UIColor colorWithRGBHex:0xe5e5e5]];
    
    //
    self.descTextView.placeholder = @"Input decription...";

    //
    self.projectImageView.layer.cornerRadius = 2;
    self.projectImageView.image = kPlaceholderCodingSquareWidth(55.0);
    UITapGestureRecognizer *tapProjectImageViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectProjectImage)];
    [self.projectImageView addGestureRecognizer:tapProjectImageViewGR];
    
    
     if (self.invitation == nil) {
    // 添加 “完成” 按钮
    self.submitButtonItem = [UIBarButtonItem itemWithBtnTitle:@"Send" target:self action:@selector(submit)];
    self.submitButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.submitButtonItem;
     } else {
         self.acceptButtonItem = [UIBarButtonItem itemWithBtnTitle:@"Accept" target:self action:@selector(accept)];
         self.acceptButtonItem.enabled = YES;
         self.navigationItem.rightBarButtonItem = self.acceptButtonItem;

     }
    
    // 默认类型
    self.projectType = NewProjectTypePrivate;

    static NSString *projectIconURLString = @"https://coding.net/static/project_icon/scenery-%d.png";
    int x = arc4random() % 24 + 1;
    NSString *randomIconURLString = [NSString stringWithFormat:projectIconURLString,x];
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:randomIconURLString] placeholderImage:kPlaceholderCodingSquareWidth(55.0) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.projectIconImage = image;
        }
    }];
}


- (void)configLocationManager
{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {//iOS 8
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}
// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager

     didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    
    CLLocation* location = [locations lastObject];
    
    self.gisLocation = location;
    
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          
           location.coordinate.latitude,
          
           location.coordinate.longitude);
    
//    self.bdCoordinate = [LocationHelper ggToBDEncrypt:self.location.coordinate];
//    
//    //    测试位置
//    //    CLLocation *tempLocation = [[CLLocation alloc]initWithLatitude:31.21463 longitude:121.526068];
//    
//    // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    __weak typeof (self)weakSelf = self;
//    //根据经纬度反向地理编译出地址信息
//    [geocoder reverseGeocodeLocation:self.location completionHandler:^(NSArray *array, NSError *error)
//     {
//         if (array.count > 0)
//         {
//             CLPlacemark *placemark = [array objectAtIndex:0];
//             //获取城市
//             NSString *city = placemark.locality;
//             if (!city) {
//                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                 city = placemark.administrativeArea;
//             }
//             weakSelf.cityName = city;
//             weakSelf.district = placemark.subLocality;
//             weakSelf.locationRequest.lat = [NSString stringWithFormat:@"%f",weakSelf.bdCoordinate .latitude];
//             weakSelf.locationRequest.lng = [NSString stringWithFormat:@"%f",weakSelf.bdCoordinate .longitude];
//             weakSelf.searchingRequest.lat = weakSelf.locationRequest.lat;
//             weakSelf.searchingRequest.lng = weakSelf.locationRequest.lng;
//             
//             weakSelf.locatioCreateRequest.longitude = weakSelf.locationRequest.lng;
//             weakSelf.locatioCreateRequest.latitude = weakSelf.locationRequest.lat;
//             
//             weakSelf.searchingCreateRequest.longitude = weakSelf.locationRequest.lng;
//             weakSelf.searchingCreateRequest.latitude = weakSelf.locationRequest.lat;
//             
//             weakSelf.mySearchBar.userInteractionEnabled = YES;
//             if (weakSelf.locationArray.count > 1) {
//                 NSString *cityName = weakSelf.locationArray[1][@"cityName"];
//                 NSString *checkmark = weakSelf.locationArray[1][@"checkmark"];
//                 if (cityName.length > 0) {
//                     [weakSelf.locationArray replaceObjectAtIndex:1 withObject:@{@"cityName":city,@"location":@{@"lat":weakSelf.locationRequest.lat,@"lng":weakSelf.locationRequest.lng},@"cellType":@"defualt",@"checkmark":checkmark}];
//                 }else{
//                     [weakSelf.locationArray insertObject:@{@"cityName":city,@"location":@{@"lat":weakSelf.locationRequest.lat,@"lng":weakSelf.locationRequest.lng},@"cellType":@"defualt",@"checkmark":@"NO"} atIndex:1];
//                 }
//             }else if(weakSelf.locationArray){
//                 [weakSelf.locationArray insertObject:@{@"cityName":city,@"location":@{@"lat":weakSelf.locationRequest.lat,@"lng":weakSelf.locationRequest.lng},@"cellType":@"defualt",@"checkmark":@"NO"} atIndex:1];
//             }
//             
//             [weakSelf.tableView reloadData];
//             
//             [weakSelf requestLocationWithObj:weakSelf.locationRequest];
//             
//             NSLog(@"city = %@", city);
//         }
//         else if (error == nil && [array count] == 0)
//         {
//             NSLog(@"No results were returned.");
//         }
//         else if (error != nil)
//         {
//             NSLog(@"An error occurred = %@", error);
//         }
//     }];
    //[manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
    //self.tableView.tableFooterView = self.locationFooterView;
    
}
//=======
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}
-(void)selectProjectImage{
    [[UIActionSheet bk_actionSheetCustomWithTitle:@"Choose a Photo" buttonTitles:@[@"Take a Photo",@"Choose a Photo"] destructiveTitle:nil cancelTitle:@"Cancel" andDidDismissBlock:^(UIActionSheet *sheet, NSInteger index) {
        
        if (index > 1) {
            return ;
        }
        
        UIImagePickerController *avatarPicker = [[UIImagePickerController alloc] init];
        avatarPicker.delegate = self;
        if (index == 0) {
            avatarPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            avatarPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        avatarPicker.allowsEditing = YES;
        [self presentViewController:avatarPicker animated:YES completion:nil];
    }] showInView:self.view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image) {
        self.projectImageView.image = image;
        self.projectIconImage = image;
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)accept{
    NSLog(@"accept");
}

-(void)submit0{
    
    NSString *projectName = [self.projectNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([projectName length] < 2 || [projectName length] > 31) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入2 ~ 31位以内的项目名称" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
    }else{
        if ([self projectNameVerification:projectName]) {
            
            // init a Project
            Project *project = [[Project alloc] init];
            project.name = projectName;
            project.description_mine = [self.descTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if (self.projectType == NewProjectTypePublic) {
                project.is_public = @YES;
            }else{
                project.is_public = @NO;
            }
            
            self.submitButtonItem.enabled = NO;
            
            // 效验完成，开始发送请求创建项目
            __weak typeof(self) weakSelf = self;
            [[Coding_NetAPIManager sharedManager] request_NewProject_WithObj:project image:self.projectIconImage andBlock:^(NSString *data, NSError *error) {
                if (data.length > 0) {
                    
                    NSString *projectRegexStr = @"/u/([^/]+)/p/([^/]+)";
                    NSArray *matchedCaptures = [data captureComponentsMatchedByRegex:projectRegexStr];
                    if (matchedCaptures.count >= 3) {
                        NSString *user_global_key = matchedCaptures[1];
                        NSString *project_name = matchedCaptures[2];
                        Project *curPro = [[Project alloc] init];
                        curPro.owner_user_name = user_global_key;
                        curPro.name = project_name;
                        //标记已读
                        [[Coding_NetAPIManager sharedManager] request_Project_UpdateVisit_WithObj:curPro andBlock:^(id dataTemp, NSError *errorTemp) {
                        }];
                        [weakSelf gotoPro:curPro];
                    }
                }
                self.submitButtonItem.enabled = YES;
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"项目名只允许字母、数字或者下划线(_)、中划线(-)，必须以字母或者数字开头,且不能以.git结尾" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
        }
    }
    
}


-(void)submit{

    NSString *projectName = [self.projectNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([projectName length] < 2 || [projectName length] > 31) {
        //[[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入2 ~ 31位以内的项目名称" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please input a valid acitivity name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }else{
        if ([self projectNameVerification:projectName]) {
            
            // init a Project
            Invitation *invitation = [[Invitation alloc] init];
            invitation.title = projectName;
            invitation.description_mine = [self.descTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            invitation.location = self.location.text;
            invitation.preferredAge = self.age.text;
            invitation.preferredGender = self.gender.text;
            invitation.location_latitude =   self.gisLocation.coordinate.latitude;
            invitation.location_longitude =  self.gisLocation.coordinate.longitude;
            
            self.submitButtonItem.enabled = NO;
            
            // 效验完成，开始发送请求创建项目
            __weak typeof(self) weakSelf = self;
            [[Coding_NetAPIManager sharedManager] request_NewInvitation_WithObj:invitation image:self.projectIconImage andBlock:^(NSString *data, NSError *error) {
                if (data.length > 0) {
                    //TODO
                    NSString *projectRegexStr = @"/u/([^/]+)/p/([^/]+)";
                    NSArray *matchedCaptures = [data captureComponentsMatchedByRegex:projectRegexStr];
                    if (matchedCaptures.count >= 3) {
                        NSString *user_global_key = matchedCaptures[1];
                        NSString *project_name = matchedCaptures[2];
                        Project *curPro = [[Project alloc] init];
                        curPro.owner_user_name = user_global_key;
                        curPro.name = project_name;
                        //标记已读
                        [[Coding_NetAPIManager sharedManager] request_Project_UpdateVisit_WithObj:curPro andBlock:^(id dataTemp, NSError *errorTemp) {
                        }];
                        [weakSelf gotoPro:curPro];
                    }
                }
                self.submitButtonItem.enabled = YES;
            }];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"项目名只允许字母、数字或者下划线(_)、中划线(-)，必须以字母或者数字开头,且不能以.git结尾" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil] show];
        }
    }

}

-(BOOL)projectNameVerification:(NSString *)projectName{
    NSString * regex = @"^[a-zA-Z0-9][a-zA-Z0-9_-]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:projectName];
    return isMatch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([str length] > 0) {
        self.submitButtonItem.enabled = YES;
    }else{
        self.submitButtonItem.enabled = NO;
    }
    
    return YES;
}

#pragma mark gotoVC
- (void)gotoPro:(Project *)curPro{
    NProjectViewController *vc = [[NProjectViewController alloc] init];
    vc.myProject = curPro;
    NSMutableArray *curViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    if (curViewControllers.count >= 2) {
        [curViewControllers replaceObjectAtIndex:curViewControllers.count - 1 withObject:vc];
        [self.navigationController setViewControllers:curViewControllers animated:YES];
    }
}

#pragma mark UITableView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        // 类型
        NewProjectTypeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewProjectTypeVC"];
        vc.projectType = self.projectType;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    if (indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
         cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
        return;
    }
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

}

#pragma mark NewProjectTypeViewController Delegate

-(void)newProjectType:(NewProjectTypeViewController *)newProjectVC didSelectType:(NewProjectType)type{
    [newProjectVC.navigationController popViewControllerAnimated:YES];
    
    //
    self.projectType = type;
    
    if (self.projectType == NewProjectTypePublic) {
        self.projectTypeLabel.text = @"公开";
    }else{
        self.projectTypeLabel.text = @"私有";
    }
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate{
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
