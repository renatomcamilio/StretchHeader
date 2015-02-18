//
//  StretchHeaderTableViewCell.m
//  StretchHeader
//
//  Created by Renato Camilio on 2/17/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "NewsEntryTableViewCell.h"

@implementation NewsEntryTableViewCell

- (void)awakeFromNib {
    self.categoryLabel.textColor = [UIColor greenColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
