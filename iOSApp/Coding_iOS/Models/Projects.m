//
//  Projects.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-1.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "Projects.h"
#import "Login.h"

@implementation Projects

- (instancetype)init
{
    self = [super init];
    if (self) {
        _canLoadMore = NO;
        _isLoading = NO;
        _willLoadMore = NO;
        _propertyArrayMap = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Invitation", @"list", nil];
    }
    return self;
}

+ (Projects *)projectsWithType:(ProjectsType)type andUser:(User *)user{
    Projects *pros = [[Projects alloc] init];
    pros.type = type;
    pros.curUser = user;
    
    pros.page = [NSNumber numberWithInteger:1];
    pros.pageSize = [NSNumber numberWithInteger:9999];
    return pros;
}

- (NSString *)typeStr{
    NSString *typeStr;
    switch (_type) {
        case  ProjectsTypeAll:
            typeStr = @"all";
            break;
        case  ProjectsTypeJoined:
            typeStr = @"joined";
            break;
        case  ProjectsTypeCreated:
            typeStr = @"created";
            break;
        case  ProjectsTypeTaProject:
            typeStr = @"project";
            break;
        case  ProjectsTypeTaStared:
            typeStr = @"stared";
            break;
        default:
            typeStr = @"all";
            break;
    }
    return typeStr;
}


- (NSDictionary *)toParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{@"page" : [NSNumber numberWithInteger:_willLoadMore? self.page.integerValue+1 : 1],
                                     @"pageSize" : self.pageSize,
                                     @"type" : [self typeStr]}];
    if (self.type == ProjectsTypeAll) {
        [params setObject:@"hot" forKey:@"sort"];
    }
    return params;
}
- (NSString *)toPath{
    NSString *path;
    if (self.type >= ProjectsTypeTaProject) {
        path = [NSString stringWithFormat:@"api/user/%@/public_projects", _curUser.global_key];
    }else{
        path = @"api/projects";
    }
    return path;
}

- (NSString *)toActPath{
    return @"activities";
}

- (NSDictionary *)toActParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
                                   @{@"longitude" : @0,
                                     @"latitude" : @0,
                                     @"type":self.typeStr
                                     }];
    if (self.type == ProjectsTypeAll) {
        [params setObject:@"hot" forKey:@"sort"];
    }
    return params;
}


- (void)configWithProjects:(Projects *)responsePros{
    self.page = responsePros.page;
    self.totalRow = responsePros.totalRow;
    self.totalPage = responsePros.totalPage;
    
    if (_willLoadMore) {
        [self.list addObjectsFromArray:responsePros.list];
    }else{
        self.list = [NSMutableArray arrayWithArray:responsePros.list];
    }
    self.canLoadMore = (self.page.integerValue < self.totalPage.integerValue);
}
- (NSArray *)pinList{
    NSArray *list = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pin.intValue == 1"];
    list = [self.list filteredArrayUsingPredicate:predicate];
    return list;
}
- (NSArray *)noPinList{
    NSArray *list = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pin.intValue == 0"];
    list = [self.list filteredArrayUsingPredicate:predicate];
    return list;
}
@end













