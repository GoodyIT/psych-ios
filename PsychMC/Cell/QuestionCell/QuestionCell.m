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
   
     __block NSMutableArray* newArray;
    
    CompletionHandler _answerCompletion;
}
@end

@implementation QuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _layout = [[MDCChipCollectionViewFlowLayout alloc] init];
//    _layout.estimatedItemSize = CGSizeMake(1.f, 1.f);
    [_collectionView setCollectionViewLayout:_layout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
  
    [_layout invalidateLayout];
    [_collectionView registerClass:[MDCChipCollectionViewCell class]
        forCellWithReuseIdentifier:@"identifier"];
    
    self.questionText.lineBreakMode = NSLineBreakByWordWrapping;
    self.questionText.numberOfLines = 0;
    [self.questionText setFont:[Setting curFont]];
    
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
    chipView.contentPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    chipView.titleLabel.text = [self getAnswers][indexPath.row];
    chipView.titleLabel.textAlignment = NSTextAlignmentLeft;
    chipView.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    chipView.titleLabel.numberOfLines = 0;
    chipView.titleLabel.adjustsFontForContentSizeCategory = YES;
    chipView.titleFont = [Setting curFont];
    chipView.titlePadding = UIEdgeInsetsMake(10, 10, 10, 14);
    chipView.titleLabel.textColor = [UIColor darkTextColor];

    chipView.accessoryView = nil;
     [chipView setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chipView setBorderWidth:2 forState:UIControlStateNormal];
    
    if ([curQuestion.selected containsObject:[self getAnswers][indexPath.row]]) {
        UIImageView* checkMark = [UIImageView new];
        checkMark.image = [UIImage imageNamed:@"icon_check"];
        [chipView setBorderColor:[UIColor blueColor] forState:UIControlStateNormal];
        chipView.accessoryView = checkMark;
        chipView.accessoryPadding = UIEdgeInsetsMake(0, 0, 0, 20);
    }
    
    if (curQuestion.isAnswerChecked) {
        [chipView setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSString* answer = [[[self getAnswers][indexPath.row] componentsSeparatedByString:@"."][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           UIImageView* checkMark = [UIImageView new];
        if ([curQuestion.corrects containsString:answer]) {
            chipView.titleLabel.textColor = [UIColor greenColor];
            checkMark.image = [UIImage imageNamed:@"icon_check_done"];
        } else if ([curQuestion.selected containsObject:[self getAnswers][indexPath.row]]){
           
            checkMark.image = [UIImage imageNamed:@"icon_x"];
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

- (CGSize) sizeOfString:(NSString*) string constrainedToWidth:(double) width {
  //  let attributes = [NSFontAttributeName ]
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:string];
    
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil,CGSizeMake(width, DBL_MAX), nil);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* string = [self getAnswers][indexPath.row];
//    UILabel * label = [[UILabel alloc] init];
//    label.text = string;
//
//    label.numberOfLines = 0;
//    CGSize maximumLabelSize = CGSizeMake(collectionView.frame.size.width - 100, 9999); //280:max width of label and 9999-max height of label.
//
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[Setting curFont] forKey:NSFontAttributeName];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrsDictionary];
    // your attributed string
    CGFloat width = collectionView.frame.size.width - 100; // whatever your desired width is
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat height = rect.size.height + 25;

    // use font information from the UILabel to calculate the size
//    CGSize expectedLabelSize = [label sizeThatFits:maximumLabelSize];

//    CGSize size = [self sizeOfString:string constrainedToWidth:collectionView.frame.size.width];
    return CGSizeMake(collectionView.frame.size.width, MAX(60, height));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (curQuestion.isAnswerChecked) {
        return [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    NSMutableArray* indexPaths = [NSMutableArray new];
    for (int i = 0; i < [[self getAnswers] count]; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    if (curQuestion.isAnswerChecked) {
        [collectionView reloadItemsAtIndexPaths:[indexPaths copy]];
        return;
    }
    
    NSString* curIndex = [NSString stringWithFormat:@"%ld", indexPath.row];
    NSString* selectedAnswer = [self getAnswers][indexPath.row];
    if ([curQuestion.type isEqualToString:@"multiple"]) {
        NSMutableArray* newSelected = [curQuestion.selected mutableCopy];
        if ([newSelected containsObject:curIndex])
        {
            [curQuestion.selected removeObject:selectedAnswer];
            [newSelected removeObject: curIndex];
        } else {
            [curQuestion.selected addObject:selectedAnswer];
            [newSelected addObject:curIndex];
        }
    } else { // Single
        curQuestion.selected = [@[selectedAnswer] mutableCopy];
    }
    
    curQuestion.numberOfTry++;
    
    if (_answerCompletion && curQuestion.numberOfTry > ([curQuestion getCorrects].count + 1)) {
        [curQuestion checkAnswer];
        if (!curQuestion.isAnsweredCorrectly) {
//            selectedAnswersIdxs = @"";
             _answerCompletion();
        }
    }
    
    [collectionView reloadItemsAtIndexPaths:[indexPaths copy]];
}

- (void) updateFlag
{
    if (curQuestion.isFlagged) {
        [_flagBtn setImage:[UIImage imageNamed:@"icon_flag_red"] forState:UIControlStateNormal];
    } else {
        [_flagBtn setImage:[UIImage imageNamed:@"icon_flag"] forState:UIControlStateNormal];
    }
}

- (IBAction) didTapFlag: (id)sender
{
    curQuestion.isFlagged = !curQuestion.isFlagged;
    [self updateFlag];
}

- (void) setHeight: (NSInteger) height
{
    self.collectionHeight.constant = height;
}

- (void) setData: (Question*) question completion:(CompletionHandler) completion
{
    curQuestion = question;
    _answerCompletion = completion;
    self.questionText.text = question.question;
    numberOfAnswers = [[self getAnswers] count];
    [self setHeight: 70 * numberOfAnswers];
    [self updateFlag];
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

@end
