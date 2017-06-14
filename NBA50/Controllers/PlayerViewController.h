//
//  PlayerViewController.h
//  NBA50
//
//  Created by ashoka on 13/06/2017.
//  Copyright © 2017 ashoka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UITableViewController

+ (instancetype)viewController;

@property (nonatomic, strong) NSString *playerImage;
@property (nonatomic, strong) NSString *playerDetail;
@property (nonatomic, weak) NSDictionary *player;

@end
