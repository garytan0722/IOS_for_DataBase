//
//  CorrectionCustomCell.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/25.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorrectionCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *IMUS;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *relate_time;

@end
