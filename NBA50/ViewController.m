//
//  ViewController.m
//  NBA50
//
//  Created by ashoka on 13/06/2017.
//  Copyright © 2017 ashoka. All rights reserved.
//

#import "ViewController.h"
#import "PlayerViewController.h"

@interface ViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *players;
//@property (nonatomic, strong)

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadData];
    [self setupViews];
}

- (void)setupViews {
    PlayerViewController *vc = [PlayerViewController viewController];
    UIPageViewController *pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    vc.player = self.players.firstObject;
    [pageVc setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    pageVc.dataSource = self;
    pageVc.view.frame = [UIScreen mainScreen].bounds;
    pageVc.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:pageVc];
    [self.view addSubview:pageVc.view];
    [pageVc didMoveToParentViewController:self];
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"player" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string=%@", string);
    NSArray *players = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.players = players;
}

- (NSInteger)indexOfViewController:(PlayerViewController *)vc {
    NSDictionary *player = vc.player;
    NSInteger index = [self.players indexOfObject:player];
    return index;
}

- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    if (self.players.count == 0 || index >= self.players.count) {
        return nil;
    }
    PlayerViewController *vc = [PlayerViewController viewController];
    vc.player = self.players[index];
    return vc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:viewController];
    if (index == 0 || index==NSNotFound) {
        return nil;
    }
    
    return [self viewControllerOfIndex:index-1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexOfViewController:viewController];
    if (index == (self.players.count - 1) || index == NSNotFound) {
        return nil;
    }
    return [self viewControllerOfIndex:index + 1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
