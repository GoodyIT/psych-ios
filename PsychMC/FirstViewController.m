//
//  FirstViewController.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "FirstViewController.h"
#import "QuestionViewController.h"
#import "TabbarViewController.h"

@interface FirstViewController ()
//@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleFunc:) name:@"add" object:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self pushQuestionViewController];
}

- (void) handleFunc: (NSNotification*) notification
{
    [self viewWillAppear:YES];
}


- (void) pushQuestionViewController
{
//    RLMResults<Question *> *questions = [Question objectsWhere:@"isFree = YES"];
//    Work* work = [Work new];
//    work.numberOfQuestions = questions.count;
//    work.curQuestionIndex = 0;

    Work* work = nil;
    NSInteger workID = ((TabbarViewController*)self.tabBarController).workID;
    if (((TabbarViewController*)self.tabBarController).workID > 0) {
       work =  [Work firstInstanceWhere:@"ID=?  LIMIT 1", @(workID)];
    } else {
        work = [[Work alloc] init];
        work.ID = [Work numberOfInstances] + 1;
        work.historyIDs = [Util randomQuestions:[Setting getNumberOfQuestions] forFree:1];
        work.numberOfQuestions = [[work.historyIDs componentsSeparatedByString:@","] count];
    }
    

    QuestionViewController *qVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    qVC.isFirstQuestion = @"First";
    qVC.work = work;
    [self.navigationController pushViewController:qVC animated:NO];
    
    [work save];
}

@end
