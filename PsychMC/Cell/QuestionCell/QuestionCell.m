//
//  QuestionCell.m
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import "QuestionCell.h"

@interface QuestionCell()
{
    NSInteger numberOfAnswers;
    Question* curQuestion;
    NSString* selectedAnswersIdxs;
     __block NSMutableArray* newArray;
    
    CompletionHandler _completion;
}
@end

@implementation QuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _layout = [[MDCChipCollectionViewFlowLayout alloc] init];
    [_collectionView setCollectionViewLayout:_layout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
  
    [_layout invalidateLayout];
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    
    self.questionText.lineBreakMode = NSLineBreakByWordWrapping;
    self.questionText.numberOfLines = 0;
    
    selectedAnswersIdxs = @"";
    newArray = [NSMutableArray new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCChipCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    MDCChipView *chipView = cell.chipView;
    chipView.titleLabel.text = [self getAnswers][indexPath.row];
    chipView.titleLabel.textAlignment = NSTextAlignmentLeft;
    chipView.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    chipView.titleLabel.numberOfLines = 0;
    chipView.titlePadding = UIEdgeInsetsMake(0, 20, 0, 20);
    
    chipView.accessoryView = nil;
     [chipView setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chipView setBorderWidth:2 forState:UIControlStateNormal];
    
    if ([[self getSelected] containsObject:[NSString stringWithFormat:@"%ld", indexPath.row]]) {
        UIImageView* checkMark = [UIImageView new];
        checkMark.image = [UIImage imageNamed:@"icon_check"];
        [chipView setBorderColor:[UIColor blueColor] forState:UIControlStateNormal];
        chipView.accessoryView = checkMark;
        chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 20);
    }
    
    if (curQuestion.isAnswerChecked) {
        NSString* answer = [[[self getAnswers][indexPath.row] componentsSeparatedByString:@"."][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           UIImageView* checkMark = [UIImageView new];
        if ([curQuestion.corrects containsString:answer]) {
            chipView.titleLabel.textColor = [UIColor greenColor];
            checkMark.image = [UIImage imageNamed:@"icon_check_done"];
        } else {
            checkMark = nil;
        }
        chipView.accessoryView = checkMark;
        chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 20);
    }
   
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return numberOfAnswers;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 60);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString* curIndex = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSString* selectedAnswer = [self getAnswers][indexPath.row];
    if ([curQuestion.type isEqualToString:@"multiple"]) {
        NSMutableArray* newSelected = [self getSelected];
        if ([newSelected containsObject:curIndex])
        {
            [curQuestion.selected removeObject:selectedAnswer];
            [newSelected removeObject: curIndex];
        } else {
            [curQuestion.selected addObject:selectedAnswer];
            [newSelected addObject:curIndex];
        }
        selectedAnswersIdxs = [NSString stringWithFormat:@"%@", [newSelected componentsJoinedByString:@","]];
    } else { // Single
        selectedAnswersIdxs = curIndex;
    }
    
    curQuestion.numberOfTry++;
    
    if (_completion && curQuestion.numberOfTry > ([curQuestion getCorrects].count + 1)) {
        [curQuestion checkAnswer];
        if (!curQuestion.isAnsweredCorrectly) {
            selectedAnswersIdxs = @"";
             _completion();
        }
    }
    
    NSMutableArray* indexPaths = [NSMutableArray new];
    for (int i = 0; i < [[self getAnswers] count]; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [collectionView reloadItemsAtIndexPaths:[indexPaths copy]];
}

- (void) setHeight: (NSInteger) height
{
    self.collectionHeight.constant = height;
}

- (void) setData: (Question*) question completion:(CompletionHandler) completion
{
    curQuestion = question;
    _completion = completion;
    self.questionText.text = question.question;
    numberOfAnswers = [[self getAnswers] count];
    [self setHeight: 70 * numberOfAnswers];
    [_layout invalidateLayout];
    [_collectionView reloadData];
}

- (NSArray*) getAnswers
{
    if ([newArray count] > 0) {
        return newArray;
    }
    [[[curQuestion.answers componentsSeparatedByString:@"#*#"] shuffledArray] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self->newArray addObject:[NSString stringWithFormat:@"%c. %@",(char)(65+idx), obj]];
    }];
    return  newArray;
}

- (NSMutableArray*) getSelected
{
    return [[selectedAnswersIdxs componentsSeparatedByString:@","] mutableCopy];
}

@end
