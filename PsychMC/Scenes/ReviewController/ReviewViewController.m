//
//  ReviewViewController.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-12.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "ReviewViewController.h"
#import "QuestionViewController.h"
#import "TabbarViewController.h"
#import "MDCCardCollectionCell.h"
#import "MaterialCards.h"

@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionID;

@property (strong, nonatomic) MDCChipCollectionViewFlowLayout *layout;

@end

@implementation ReviewViewController

static NSString * const reuseIdentifier = @"Cell";

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_layout != nil) {
        [_layout invalidateLayout];
        [self.collectionView reloadData];
    }
    
    ((TabbarViewController*)self.tabBarController).workID = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    _layout = [[MDCChipCollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:_layout];
    
    [_layout invalidateLayout];
//    [self.collectionView registerClass:[MDCCardCollectionCell class]
//        forCellWithReuseIdentifier:@"identifier"];
//
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [Work allInstances].count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width - 30) / 2;
    return CGSizeMake( width, width);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCCardCollectionCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier"
                                              forIndexPath:indexPath];
    // If you wanted to have the card show the selected state when tapped
    // then you need to turn selectable to true, otherwise the default is false.
    [cell setSelectable:YES];

    UILabel* reviewID = [cell viewWithTag:1];
    UILabel* total = [cell viewWithTag:2];
    UILabel* missed = [cell viewWithTag:3];
    UILabel* flagged = [cell viewWithTag:4];
    UILabel* spentTime = [cell viewWithTag:5];
    
    NSArray<Work*> *allWork = [Work allInstances];
    Work* work = allWork[indexPath.row];
    
    reviewID.text = [NSString stringWithFormat:@"%ld", work.ID];
    total.text = [NSString stringWithFormat:@"%ld", [work numberOfQuestions]];
    missed.text = [NSString stringWithFormat:@"%ld", [work numberOfMissedQuestions]];
    flagged.text = [NSString stringWithFormat:@"%ld", [work numberOfFlaggedQuestions]];
    spentTime.text = [NSString stringWithFormat:@"%lld", work.totalTime];
    

    [cell setCornerRadius:8.f];
    [cell setShadowElevation:6.f forState:MDCCardCellStateSelected];
    [cell setShadowColor:[UIColor blackColor] forState:MDCCardCellStateHighlighted];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    QuestionViewController *qVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuestionViewController"];
//    qVC.isFirstQuestion = @"First";
    NSArray<Work*> *allWork = [Work allInstances];
//    [self.navigationController pushViewController:qVC animated:NO];
    ((TabbarViewController*)self.tabBarController).workID =  allWork[indexPath.row].ID;
//    UIView * fromView = self.tabBarController.selectedViewController.view;
//    UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:0] view];
//
//    // Transition using a page curl.
//    [UIView transitionFromView:fromView
//                        toView:toView
//                      duration:0.5
//                       options:(0 > self.tabBarController.selectedIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
//                    completion:^(BOOL finished) {
//                        if (finished) {
//                            self.tabBarController.selectedIndex = 0;
//                        }
//                    }];
    self.tabBarController.selectedIndex = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:nil];    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
