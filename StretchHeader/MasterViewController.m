//
//  MasterViewController.m
//  StretchHeader
//
//  Created by Renato Camilio on 2/17/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NewsEntryTableViewCell.h"
#import "NewsItem.h"

@interface MasterViewController ()
@property NSMutableArray *objects;
@property (nonatomic, strong) NSIndexPath *lastSelectedRowIndexPath;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CAShapeLayer *headerMaskLayer;
@end

@implementation MasterViewController

static CGFloat kTableHeaderHeight = 300.f;
static CGFloat kTableHeaderCutAway = 80.f;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadObjects];
    
    // We "steal" the tableHeaderView from tableView to manage it soon
    self.headerView = self.tableView.tableHeaderView;
    self.tableView.tableHeaderView = nil;
    
    // We add tableViewHeader again manually as a child to tableView, so it remains in the view hierarchy
    [self.tableView addSubview:self.headerView];
    
    // Stretchy Header aspects
    CGFloat effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway / 2;
    self.tableView.contentInset = UIEdgeInsetsMake(effectiveHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -effectiveHeight);
    
    // header cutAway
    self.headerMaskLayer = [CAShapeLayer layer];
    self.headerMaskLayer.fillColor = [UIColor blackColor].CGColor;
    self.headerView.layer.mask = self.headerMaskLayer;
    
    [self updateHeaderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50.f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView scrollToRowAtIndexPath:self.lastSelectedRowIndexPath
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Load Data

- (void)loadObjects {
    self.objects = [NSMutableArray arrayWithArray:@[
        [NewsItem newsItemWithCategory:@"World"
                           andHeadline:@"Climate change protests, divestments meet fossil fuels realities"],
        [NewsItem newsItemWithCategory:@"Europe"
                           andHeadline:@"Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"],
        [NewsItem newsItemWithCategory:@"Middle East"
                           andHeadline:@"Airstrikes boost Islamic State, FBI director warns more hostages possible"],
        [NewsItem newsItemWithCategory:@"Africa"
                           andHeadline:@"Nigeria says 70 dead in building collapse; questions S. Africa victim claim"],
        [NewsItem newsItemWithCategory:@"Asia Pacific"
                           andHeadline:@"Despite UN ruling, Japan seeks backing for whale hunting"],
        [NewsItem newsItemWithCategory:@"Americas"
                           andHeadline:@"Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"],
        [NewsItem newsItemWithCategory:@"World"
                           andHeadline:@"South Africa in $40 billion deal for Russian nuclear reactors"],
        [NewsItem newsItemWithCategory:@"Europe"
                           andHeadline:@"'One million babies' created by EU student exchanges"]
        ]];
}

#pragma mark - Header View

- (void)updateHeaderView {
    CGFloat effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway / 2;
    CGRect headerRect = CGRectMake(0, -effectiveHeight, self.tableView.bounds.size.width, kTableHeaderHeight);
    
    if (self.tableView.contentOffset.y < -effectiveHeight) {
        headerRect.origin.y = self.tableView.contentOffset.y;
        headerRect.size.height = -self.tableView.contentOffset.y + kTableHeaderCutAway / 2;
    }
    
    self.headerView.frame = headerRect;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width, 0)];
    [path addLineToPoint:CGPointMake(headerRect.size.width, headerRect.size.height)];
    [path addLineToPoint:CGPointMake(0, headerRect.size.height - kTableHeaderCutAway / 1.5)];
    
    self.headerMaskLayer.path = path.CGPath;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (NewsEntryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsEntryCell" forIndexPath:indexPath];

    NewsItem *newsItem = self.objects[indexPath.row];
    NSString *categoryText = newsItem.category;
    
    cell.categoryLabel.text = categoryText;
    cell.categoryLabel.textColor = [newsItem categoryColor];
    
    cell.headlineLabel.text = newsItem.headline;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.lastSelectedRowIndexPath = indexPath;
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateHeaderView];
}

@end
