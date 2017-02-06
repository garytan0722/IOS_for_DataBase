//
//  SaveVC.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBModels.h"
#import "DBsqlite.h"
@interface SaveVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *leftupper;
@property (weak, nonatomic) IBOutlet UITextField *leftlower;
@property (weak, nonatomic) IBOutlet UITextField *rightupper;
@property (weak, nonatomic) IBOutlet UITextField *rightlower;
- (IBAction)Save:(id)sender;
- (IBAction)ClearBLEAll:(id)sender;
@property (strong, nonatomic) BLE_Devices *BLE;
@property (strong, nonatomic) History *history;
@property (strong, nonatomic) DBsqlite *Sqlite;
- (IBAction)AddIMUData:(id)sender;
- (IBAction)Clear_IMU:(id)sender;
- (IBAction)AddIMUCorrection:(id)sender;
- (IBAction)ClearIMUCorrection:(id)sender;
- (IBAction)AddHistory:(id)sender;

- (IBAction)ClearHistory:(id)sender;

@end
