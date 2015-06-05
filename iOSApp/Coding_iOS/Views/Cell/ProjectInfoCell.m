//
//  ProjectInfoCell.m
//  Coding_iOS
//
//  Created by Ease on 15/3/12.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#define kProjectInfoCell_ProImgViewWidth kScaleFrom_iPhone5_Desgin(55.0)

#import "ProjectInfoCell.h"
#import <MarqueeLabel/MarqueeLabel.h>

@interface ProjectInfoCell ()<TTTAttributedLabelDelegate>
@property (strong, nonatomic) UIImageView *proImgView, *recommendedView;
@property (strong, nonatomic) UILabel *proTitleL;
@property (strong, nonatomic) UITTTAttributedLabel *proInfoL;
@property (strong, nonatomic) UIView *lineView;
@end

@implementation ProjectInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!_proImgView) {
            _proImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kProjectInfoCell_ProImgViewWidth, kProjectInfoCell_ProImgViewWidth)];
            _proImgView.layer.cornerRadius = 2.0;
            _proImgView.layer.masksToBounds = YES;
            [self.contentView addSubview:_proImgView];
        }
        if (!_proTitleL) {
            
//            滚动Label
//            _proTitleL = ({
//                MarqueeLabel *label = [[MarqueeLabel alloc] initWithFrame:CGRectZero rate:50.0 andFadeLength:20];
//                label.marqueeType = MLContinuous;
//                label.trailingBuffer = 30.0f;
//                label;
//            });
            
            _proTitleL = [[UILabel alloc] init];
            _proTitleL.font = [UIFont systemFontOfSize:17];
            _proTitleL.textColor = [UIColor colorWithHexString:@"0x222222"];
            [self.contentView addSubview:_proTitleL];
        }
        if (!_proInfoL) {
            _proInfoL = [[UITTTAttributedLabel alloc] init];
            _proInfoL.delegate = self;
            _proInfoL.linkAttributes = kLinkAttributes;
            _proInfoL.activeLinkAttributes = kLinkAttributesActive;
            _proInfoL.font = [UIFont systemFontOfSize:13];
            _proInfoL.textColor = [UIColor colorWithHexString:@"0x999999"];
            [self.contentView addSubview:_proInfoL];
        }
        if (!_lineView) {
            _lineView = [[UIView alloc] init];
            _lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dot_line"]];
            [self.contentView addSubview:_lineView];
        }
        if (!_recommendedView) {
            _recommendedView = [[UIImageView alloc] init];
            _recommendedView.image = [UIImage imageNamed:@"icon_recommended"];
            [self.contentView addSubview:_recommendedView];
        }
    }
    return self;
}

+ (CGFloat)cellHeight{
    
    return kScaleFrom_iPhone5_Desgin(80.0);
}

- (void)setCurProject:(Project *)curProject{
    _curProject = curProject;
    if (!_curProject) {
        return;
    }
    [_proImgView sd_setImageWithURL:[_curProject.icon urlImageWithCodePathResize:2*kProjectInfoCell_ProImgViewWidth] placeholderImage:kPlaceholderCodingSquareWidth(55.0)];
    _proTitleL.text = [NSString stringWithFormat:@"%@/%@", _curProject.owner_user_name, _curProject.name];
    
    NSString *proInfoStr = [self proInfoStr];
    _proInfoL.text = proInfoStr;
    
    if (_curProject.is_public.boolValue && proInfoStr.length > 0) {
        NSRange range = [proInfoStr rangeOfString:_curProject.parent_depot_path];
        if (range.location != NSNotFound) {
            [_proInfoL addLinkToTransitInformation:@{} withRange:range];
        }
    }
    _proInfoL.hidden = !(proInfoStr.length > 0);
    _recommendedView.hidden = !(_curProject.recommended.integerValue > 0);
    
    // 如果是自己所属的项目才显示箭头
    if ([self.curProject.owner_id isEqual:[Login curLoginUser].id]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (NSString *)proInfoStr{
    NSString *proInfoStr = nil;
    if (_curProject.is_public.boolValue && _curProject.parent_depot_path.length > 0) {
        proInfoStr = [NSString stringWithFormat:@"Fork 自 %@", _curProject.parent_depot_path];
    }else if (!_curProject.is_public.boolValue && _curProject.description_mine.length > 0){
        proInfoStr = _curProject.description_mine;
    }
    return proInfoStr;
}


- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat pading = kPaddingLeftWidth;
    BOOL hasDetail = [[self proInfoStr] length] > 0;
    BOOL is_recommended = _curProject.recommended.integerValue > 0;
    CGFloat titleWidth = [_proTitleL.text getWidthWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 20)];
    
    [_proImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(pading);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kProjectInfoCell_ProImgViewWidth, kProjectInfoCell_ProImgViewWidth));
    }];
    [_proTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_proImgView.mas_right).offset(pading);
        make.width.mas_lessThanOrEqualTo(titleWidth);
        if (hasDetail) {
            make.centerY.equalTo(_proImgView.mas_centerY).offset(-kProjectInfoCell_ProImgViewWidth/5);
        }else{
            make.centerY.equalTo(_proImgView.mas_centerY);
        }
        make.height.mas_equalTo(20);
    }];
    [_recommendedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_lessThanOrEqualTo(self.contentView.mas_right);
        make.left.equalTo(_proTitleL.mas_right).offset(5);
        make.centerY.equalTo(_proTitleL.mas_centerY);
        make.size.mas_equalTo(is_recommended? CGSizeMake(20, 20): CGSizeZero);
    }];
    [_proInfoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_proTitleL);
        make.right.equalTo(self.contentView.mas_right);
        make.centerY.equalTo(_proImgView.mas_centerY).offset(kProjectInfoCell_ProImgViewWidth/5);
        make.height.mas_equalTo(15);
    }];
    [_lineView setFrame:CGRectMake(pading, [ProjectInfoCell cellHeight] - 1.0, kScreen_Width - 2*pading, 1.0)];
}

#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    if (_curProject.parent_depot_path && _projectBlock) {
        NSArray *dataList = [_curProject.parent_depot_path componentsSeparatedByString:@"/"];
        if (dataList.count == 2) {
            Project *curPro = [[Project alloc] init];
            curPro.owner_user_name = dataList[0];
            curPro.name = dataList[1];
            _projectBlock(curPro);
        }
    }
}
@end
