//
//  FirstViewController.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "FirstViewController.h"
#import "QuestionViewController.h"

@interface FirstViewController ()
//@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self pushQuestionViewController];
}


- (void) pushQuestionViewController
{
//    RLMResults<Question *> *questions = [Question objectsWhere:@"isFree = YES"];
//    Work* work = [Work new];
//    work.numberOfQuestions = questions.count;
//    work.curQuestionIndex = 0;

    NSLog(@"all works %@", [Work allInstances]);
    Work* work = [[Work alloc] init];
    work.ID = [Work numberOfInstances] + 1;
    work.numberOfQuestions = [[Question allInstances] count];
    work.historyIDs = @"";
   
    QuestionViewController *qVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    qVC.isFirstQuestion = @"First";
    qVC.work = work;
    [self.navigationController pushViewController:qVC animated:NO];
}

@end
