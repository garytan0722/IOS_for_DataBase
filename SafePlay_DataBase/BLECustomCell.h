//
//  CustomCell.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLECustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftupper;

@property (weak, nonatomic) IBOutlet UILabel *leftlower;
@property (weak, nonatomic) IBOutlet UILabel *rightupper;
@property (weak, nonatomic) IBOutlet UILabel *rightlower;

@end
