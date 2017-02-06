//
//  IMUCustomCell.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMUCustomCell : UITableViewCell


@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *IMUS;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end
