//
//  IMU_CorrectionQueryVC.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/25.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
@interface IMU_CorrectionQueryVC : UITableViewController
@property(weak,nonatomic) DBsqlite *sqlite;
@end
