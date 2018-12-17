//
//  QuestionViewController.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "QuestionViewController.h"
#import "MaterialCards.h"
#import "QuestionCell.h"
#import "ActionCell.h"
#import "CardCell.h"

@interface QuestionViewController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
{
    __block NSInteger numberOfSections;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (strong, nonatomic) Question* curQuestion;
@property(nonatomic) MDCDialogTransitionController *resultView;

@end

@implementation QuestionViewController

- (void) viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    
    if (_isFirstQuestion != nil) {
         [self.navigationItem setHidesBackButton:YES animated:NO];
    } else {
//        [self.navigationItem setHidesBackButton:NO animated:NO];
    }

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    if (self.work.curQuestionIndex + 1 < self.work.numberOfQuestions) {
        UIBarButtonItem* nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(gotoNext:)];

        self.navigationItem.rightBarButtonItem = nextBtn;
    } else {
        UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
        self.navigationItem.rightBarButtonItem = doneBtn;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self prepareUI];
    
    [self initData];
}

- (void) initData
{
    _curQuestion = [Util getQuestionAtIndex:_work.curQuestionIndex forQuestions:_work.historyIDs];
    [_curQuestion initData];
    numberOfSections = 2;
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld", _work.curQuestionIndex + 1, _work.numberOfQuestions];
}

- (void) prepareUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionCell" bundle:nil] forCellReuseIdentifier:@"QuestionCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActionCell" bundle:nil] forCellReuseIdentifier:@"ActionCell"];
    
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftGesture:)];
    [self.view addGestureRecognizer:swipeLeftGesture];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeRightGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture:)];
    [self.view addGestureRecognizer:swipeRightGesture];
    swipeRightGesture.direction=UISwipeGestureRecognizerDirectionRight;

}

-(void)handleSwipeLeftGesture:(UIGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (self.work.curQuestionIndex + 1 < self.work.numberOfQuestions) {
            [self gotoNext:nil];
        }
    }
}

-(void)handleSwipeRightGesture:(UIGestureRecognizer *) sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (self.work.curQuestionIndex > 0) {
            [self gotoPrev:nil];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// Actions for navigation items
- (void)onTapDone:(id)sender {
    [self saveAnswersStatus];
    
    NSString* message = [NSString stringWithFormat:@"Out of %ld Questions \n %ld Wrong Answers\n %ld Flagged Questions\n", _work.numberOfQuestions, [_work numberOfWrongQuestions], [_work numberOfFlaggedQuestions]];
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:@"Title"
                                         message:message];

    MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
                                NSLog(@"OK");
                            }];
    
    [alertController addAction:alertAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) saveAnswersStatus
{
    if (!_curQuestion.isAnsweredCorrectly) {
        [_work updateWrongQuestions:_curQuestion.ID];
        NSLog(@"wrongly answered question %lld, all wrong answered Questions %@", _curQuestion.ID, _work.wrongQuestions);
    }
    if (!_curQuestion.isAnswerChecked) {
        [_work updateMissedQuestions:_curQuestion.ID];
        NSLog(@"skipped question %lld, all missed Questions %@", _curQuestion.ID, _work.missedQuestions);
    }
//    
    [_work updateFlaggedQuestions:_curQuestion];
    [self.work save];
}

- (void)gotoNext:(id)sender {
    _work.curQuestionIndex++;
    [self saveAnswersStatus];
    [_work updateFlaggedQuestions:_curQuestion];
    [self.work save];
    [self pushQuestionViewController];
}

- (void) gotoPrev: (id) sender {
    _work.curQuestionIndex--;
    [_work updateFlaggedQuestions:_curQuestion];
    [self.work save];
    [self popQuestionViewController];
}

- (void) pushQuestionViewController
{
    QuestionViewController *qVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    qVC.work = self.work;
    [self.navigationController pushViewController:qVC animated:YES];
}

- (void) popQuestionViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) expandTable
{
    if (![_work.mode isEqualToString:@"test"]) {
        self->numberOfSections = 3;
        [_work save];
        [self.tableView reloadData];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberOfSections;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return tableView.frame.size.height / 3;
//    } else if (indexPath.section == 1){
//        return 60;
//    }
//
//    return 200;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QuestionCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
        
        [cell setData: _curQuestion completion:^{
            [self expandTable];
        }];
        return cell;
    } else if (indexPath.section == 1) {
        ActionCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"ActionCell" forIndexPath:indexPath];
        
        cell.checkHandler = ^{
            [self->_curQuestion checkAnswer];
            self->_curQuestion.isBtnTriggered = YES;
            [self expandTable];
        };
        return cell;
    }
  
    // section 2
    CardCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"CardCell" forIndexPath:indexPath];
    
    [cell updateText:_curQuestion];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
