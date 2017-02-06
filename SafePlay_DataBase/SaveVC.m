//
//  SaveVC.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "SaveVC.h"
#import "DBModels.h"
#import "DBsqlite.h"
#import "BLEQueryVC.h"
#import "IMUQueryVC.h"
#import "IMU_CorrectionQueryVC.h"
#import "HistoryVC.h"
@interface SaveVC (){
    NSMutableArray<IMU *> *LeftUpIMU;
    NSMutableArray<IMU *> *LeftLowerIMU;
    NSMutableArray<IMU *> *RightUpIMU;
    NSMutableArray<IMU *> *RightLowerIMU;
    NSMutableArray<IMU_Correction *> *IMUCorrection;
    IMU *LeftUpIMUOneFrame;
    IMU *LeftLowerIMUOneFrame;
    IMU *RightUpIMUOneFrame;
    IMU *RightLowerIMUOneFrame;
    IMU_Correction *IMU_CorrectionOneFrame;
    NSDateFormatter *ForMatter;
}
@end

@implementation SaveVC
@synthesize BLE;
@synthesize history;
@synthesize Sqlite;
- (void)viewDidLoad {
    [super viewDidLoad];
    BLE=[[ BLE_Devices alloc]init];//BLE
    history=[[History alloc] init];//history
    Sqlite=[[DBsqlite alloc]init];
    LeftUpIMU = [[NSMutableArray alloc] init];//IMU
    LeftLowerIMU = [[NSMutableArray alloc] init];//IMU
    RightUpIMU = [[NSMutableArray alloc] init];//IMU
    RightLowerIMU = [[NSMutableArray alloc] init];//IMU
    IMUCorrection=[[NSMutableArray alloc] init];//IMU_Correction
    ForMatter = [[NSDateFormatter alloc] init];
    [ForMatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.SSS"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Save:(id)sender {
    BLE.leftknee_lowerimu=self.leftlower.text;
    BLE.leftknee_upperimu=self.leftupper.text;
    BLE.rightknee_lowerimu=self.rightlower.text;
    BLE.rightknee_upperimu=self.rightupper.text;
    [Sqlite AddBLE:BLE];
    self.leftlower.text=nil;
    self.leftupper.text=nil;
    self.rightlower.text=nil;
    self.rightupper.text=nil;
}

- (IBAction)ClearBLEAll:(id)sender {
    [Sqlite ClearBLEAll];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"gotoble"]){
        NSLog(@"gotoble");
        BLEQueryVC *query=segue.destinationViewController;
        query.sqlite=self.Sqlite;
    }
    if([segue.identifier isEqualToString:@"gotoimu"]){
        NSLog(@"gotoimu");
        IMUQueryVC *query=segue.destinationViewController;
        query.sqlite=self.Sqlite;
    }
    if([segue.identifier isEqualToString:@"gotocorrection"]){
        NSLog(@"gotocorrection");
        IMU_CorrectionQueryVC *query=segue.destinationViewController;
        query.sqlite=self.Sqlite;
    }
    if([segue.identifier isEqualToString:@"gotohistory"]){
        NSLog(@"gotohistory");
        HistoryVC *query=segue.destinationViewController;
        query.sqlite=self.Sqlite;
    }
}
-(IMU *)SetIMU:(NSString *)time
{
    IMU *imu = [[IMU alloc] init];
    imu.datetime=time;
    for(int i=0;i<9;i++){
        imu.imu[i]=arc4random() % 100;
    }
    return imu;
}
-(IMU_Correction *)SetIMUCorrection:(int)t relatetime:(NSString*)relatetime{
    IMU_Correction *imu_correction = [[IMU_Correction alloc] init];
    imu_correction.datetime=relatetime;
    imu_correction.type=t;
    for(int i=0;i<9;i++){
        imu_correction.imu[i]=arc4random() % 100;
    }
    return imu_correction;
}
- (IBAction)AddIMUData:(id)sender {
    for(int i=0;i<3;i++){
        LeftUpIMUOneFrame=[self SetIMU:[ForMatter stringFromDate: [NSDate date]]];
        [LeftUpIMU addObject:LeftUpIMUOneFrame];
        LeftLowerIMUOneFrame=[self SetIMU:[ForMatter stringFromDate: [NSDate date]]];
        [LeftLowerIMU addObject:LeftLowerIMUOneFrame];
        
        RightUpIMUOneFrame=[self SetIMU:[ForMatter stringFromDate: [NSDate date]]];
        [RightUpIMU addObject:RightUpIMUOneFrame];
        
        RightLowerIMUOneFrame=[self SetIMU:[ForMatter stringFromDate: [NSDate date]]];
        [RightLowerIMU addObject:RightLowerIMUOneFrame];
    }
    [Sqlite AddUpperIMULeftAll:LeftUpIMU];
    [Sqlite AddLowerIMULeftAll:LeftLowerIMU];
    [Sqlite AddUpperIMURightAll:RightUpIMU];
    [Sqlite AddLowerIMURightAll:RightLowerIMU];
}

- (IBAction)Clear_IMU:(id)sender {
    [LeftUpIMU removeAllObjects];
    [LeftLowerIMU removeAllObjects];
    [RightUpIMU removeAllObjects];
    [RightLowerIMU removeAllObjects];
    [Sqlite ClearAllIMU];
}

- (IBAction)AddIMUCorrection:(id)sender {
    for(int i=0 ;i<3;i++){
        IMU_CorrectionOneFrame=[self SetIMUCorrection:i relatetime:[ForMatter stringFromDate: [NSDate date]]];
        [IMUCorrection addObject:IMU_CorrectionOneFrame];
    }
    [Sqlite AddIMUCorrectionAll:IMUCorrection];
}

- (IBAction)ClearIMUCorrection:(id)sender {
    [IMUCorrection removeAllObjects];
    [Sqlite ClearAllIMUCorrection];
}

- (IBAction)AddHistory:(id)sender {
    NSDate *current = [NSDate date];
    NSTimeInterval addonehour = 1 * 60 * 60;
    NSTimeInterval addtwohour = 2 * 60 * 60;
    NSDate *dateOneHoursAhead = [current dateByAddingTimeInterval:addonehour];
    NSDate *dateTwoHoursAhead = [current dateByAddingTimeInterval:addtwohour];
    history.type=arc4random() % 10;
    history.start_time=[ForMatter stringFromDate: [NSDate date]];
    history.finish_time=[ForMatter stringFromDate:dateOneHoursAhead];
    history.relate_time=[ForMatter stringFromDate:dateTwoHoursAhead];
    [Sqlite AddHistoryAll:history];
}

- (IBAction)ClearHistory:(id)sender {
    [Sqlite ClearHistoryAll];
}
@end
