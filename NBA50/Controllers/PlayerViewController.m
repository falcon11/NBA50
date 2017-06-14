//
//  PlayerViewController.m
//  NBA50
//
//  Created by ashoka on 13/06/2017.
//  Copyright © 2017 ashoka. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextView *textView;
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UITableViewCell *tableViewCell;

@end

@implementation PlayerViewController

+ (instancetype)viewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:@"PlayerViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupViews];
    [self updateViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.textView setContentOffset:CGPointZero animated:NO];
}

- (void)setupViews {
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topLayoutGuide.length,
                                           0.0,
                                           self.bottomLayoutGuide.length,
                                           0.0);
//    _tableView.contentInset = insets;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    _tableView.estimatedRowHeight = 141;
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    _tableView.tableHeaderView = self.imageView;
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 0.0001)];
}

- (void)updateViews {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:weakSelf.playerImage]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.image = image;
            [weakSelf.tableView reloadData];
        });
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.textView.text = weakSelf.playerDetail;
        [weakSelf.textView sizeToFit];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setPlayer:(NSDictionary *)player {
    _player = player;
    self.playerImage = player[@"image"];
    self.playerDetail = player[@"detail"];
    [self updateViews];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return _tableViewCell;
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.textView sizeToFit];
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    CGSize imgSize = [self.imageView sizeThatFits:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    return textSize.height + imgSize.height;
}

@end
