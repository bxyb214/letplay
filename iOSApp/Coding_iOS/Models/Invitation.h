//
//  Invitation.h
//  Lets_Play
//
//  Created by HongDongZhao on 5/31/15.
//  Copyright (c) 2015 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invitation : NSObject
@property (readwrite, nonatomic, strong) NSString *title, *description_mine, *preferredGender, *preferredAge, *location,
    *start_time, *created_time, *updated_time, *created_at, *updated_at,*end_time, *acceptable, *user_id;


@property (readwrite) double  location_longitude, location_latitude, distance;

- (NSString *)toCreatePath;
- (NSDictionary *)toCreateParams;
- (NSString *)toUpdatePath;
- (NSDictionary *)toUpdateParams;
@end
