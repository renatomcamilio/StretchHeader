//
//  StretchHeaderTableViewCell.h
//  StretchHeader
//
//  Created by Renato Camilio on 2/17/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsEntryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;

@end
