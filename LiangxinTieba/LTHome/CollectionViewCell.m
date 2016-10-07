//
//  CollectionViewCell.m
//  LiangxinTieba
//
//  Created by mac on 2016/9/28.
//  Copyright © 2016年 XYD. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor greenColor];
    self.barName.backgroundColor = [UIColor yellowColor];
    
    self.layer.cornerRadius = 15;
    
    self.layer.borderWidth = 3;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
}

@end
