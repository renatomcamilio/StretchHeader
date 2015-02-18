//
//  NewsItem.m
//  StretchHeader
//
//  Created by Renato Camilio on 2/17/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

- (UIColor *)categoryColor {
    UIColor *color = [UIColor brownColor]; // Default color for World
    
    if ([self.category isEqualToString:@"Americas"]) {
        color = [UIColor purpleColor];
    } else if ([self.category isEqualToString:@"Europe"]) {
        color = [UIColor redColor];
    } else if ([self.category isEqualToString:@"Middle East"]) {
        color = [UIColor blueColor];
    } else if ([self.category isEqualToString:@"Africa"]) {
        color = [UIColor yellowColor];
    } else if ([self.category isEqualToString:@"Asia Pacific"]) {
        color = [UIColor lightGrayColor];
    }
    
    return color;
}

+ (instancetype)newsItemWithCategory:(NSString *)category andHeadline:(NSString *)headline {
    NewsItem *newsItem = [[self alloc] init];
    newsItem.category = category;
    newsItem.headline = headline;
    
    return newsItem;
}

@end
