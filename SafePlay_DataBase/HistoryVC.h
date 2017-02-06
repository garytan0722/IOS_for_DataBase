//
//  HistoryVC.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/2/6.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "HistoryCustomCell.h"
@interface HistoryVC : UITableViewController
@property(weak,nonatomic) DBsqlite *sqlite;
@end
