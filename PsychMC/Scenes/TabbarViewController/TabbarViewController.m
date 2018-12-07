//
//  TabbarViewController.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-07.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [((UINavigationController*)viewController).viewControllers.firstObject viewWillAppear:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
