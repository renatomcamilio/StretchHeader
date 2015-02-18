//
//  NewsItem.h
//  StretchHeader
//
//  Created by Renato Camilio on 2/17/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NewsItem : NSObject

/* Possible Categories:
 * World, Americas, Europe, Middle East, Africa, Asia Pacific
 */

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *headline;

+ (instancetype)newsItemWithCategory:(NSString *)category andHeadline:(NSString *)headline;
- (UIColor *)categoryColor;

@end
