//
//  TableViewCell.h
//  LiangxinTieba
//
//  Created by mac on 2016/9/28.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *barName;
@property (weak, nonatomic) IBOutlet UILabel *tieReplyNum;

@property (weak, nonatomic) IBOutlet UILabel *tieName;
@property (weak, nonatomic) IBOutlet UILabel *tieDescription;
@property (weak, nonatomic) IBOutlet UIImageView *tieImg1;
@property (weak, nonatomic) IBOutlet UIImageView *tieImg2;
@property (weak, nonatomic) IBOutlet UIImageView *tieImg3;

@property (weak, nonatomic) IBOutlet UILabel *tieAuthor;
@property (weak, nonatomic) IBOutlet UILabel *tieTime;

@end
