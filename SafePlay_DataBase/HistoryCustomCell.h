//
//  HistoryCustomCell.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/2/6.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UILabel *start_time;
@property (weak, nonatomic) IBOutlet UILabel *finish_time;
@property (weak, nonatomic) IBOutlet UILabel *relate_time;

@end
