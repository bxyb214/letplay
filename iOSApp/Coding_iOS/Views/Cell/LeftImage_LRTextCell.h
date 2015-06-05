//
//  LeftImage_LRTextCell.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-19.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#define kCellIdentifier_LeftImage_LRText @"LeftImage_LRTextCell"

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LeftImage_LRTextCellType) {
    LeftImage_LRTextCellTypeTaskOwner = 0,
    LeftImage_LRTextCellTypeTaskPriority,
    LeftImage_LRTextCellTypeTaskDeadline,
    LeftImage_LRTextCellTypeTaskStatus
};

@interface LeftImage_LRTextCell : UITableViewCell

- (void)setObj:(id)aObj type:(LeftImage_LRTextCellType)type;

+ (CGFloat)cellHeight;
@end