//
//  QuestionCell.h
//  PsychMC
//
//  Created by Denning IT on 2018-12-05.
//  Copyright © 2018 Clint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (weak, nonatomic) IBOutlet UILabel *questionText;
@property (strong, nonatomic) MDCChipCollectionViewFlowLayout *layout;

- (void) setHeight: (NSInteger) height;

- (void) setData: (Question*) question completion:(CompletionHandler) completion;

@end

NS_ASSUME_NONNULL_END
