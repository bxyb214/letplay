//
//  Project.h
//  Coding_iOS
//
//  Created by Ease on 15/4/23.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property (readwrite, nonatomic, strong) NSString *icon, *name, *owner_user_name, *backend_project_path, *full_name, *description_mine, *path, *parent_depot_path;
@property (readwrite, nonatomic, strong) NSNumber *id, *owner_id, *is_public, *un_read_activities_count, *done, *processing, *star_count, *stared, *watch_count, *watched, *fork_count, *forked, *recommended, *pin;
@property (assign, nonatomic) BOOL isStaring, isWatching, isLoadingMember, isLoadingDetail;

@property (strong, nonatomic) NSString *readMeHtml;
@property (assign, nonatomic) CGFloat readMeHeight;

+ (Project *)project_All;
+ (Project *)project_FeedBack;

- (NSString *)toProjectPath;
- (NSDictionary *)toCreateParams;

- (NSString *)toUpdatePath;
- (NSDictionary *)toUpdateParams;

- (NSString *)toUpdateIconPath;

- (NSString *)toDeletePath;
- (NSDictionary *)toDeleteParamsWithPassword:(NSString *)password;

- (NSString *)toMembersPath;
- (NSDictionary *)toMembersParams;

- (NSString *)toUpdateVisitPath;
- (NSString *)toDetailPath;

- (NSString *)localMembersPath;

- (NSString *)toBranchOrTagPath:(NSString *)path;
@end
