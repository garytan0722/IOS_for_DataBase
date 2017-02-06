//
//  DBsqlite.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#ifndef DBsqlite_h
#define DBsqlite_h
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "DBModels.h"
@interface DBsqlite : NSObject
@property (strong, nonatomic) FMDatabaseQueue *queue;
- (instancetype) initWithNewDatabase;
- (void) Realease;
/****** BLE_Devices methods ******/
- (BOOL) AddBLE:(BLE_Devices *)newBLE;
- (NSMutableArray *) GetBLEAll;
- (void) ClearBLEAll;
/****** BLE_Devices methods ******/

/****** IMU methods ******/
- (BOOL) AddUpperIMULeftAll:(NSMutableArray *)data;
- (BOOL) AddLowerIMULeftAll:(NSMutableArray *)data;
- (BOOL) AddUpperIMURightAll:(NSMutableArray *)data;
- (BOOL) AddLowerIMURightAll:(NSMutableArray *)data;
- (NSMutableArray *) GetUpperIMULeft:(NSString *)time;
- (NSMutableArray *) GetLowerIMULeft:(NSString *)time;
- (NSMutableArray *) GetUpperIMURight:(NSString *)time;
- (NSMutableArray *) GetLowerIMURight:(NSString *)time;
- (void) ClearAllIMU;
/****** IMU methods ******/

/****** IMU_Correction methods ******/
- (BOOL) AddIMUCorrectionAll:(NSMutableArray *)data;
- (NSMutableArray *) GetIMUCorrectionAll:(NSString *)relate_time;
-(void)ClearAllIMUCorrection;
/****** IMU_Correction methods ******/

/****** History methods ******/
- (BOOL) AddHistoryAll:(History *)newHistory;
- (NSMutableArray *) GetHistoryAll;
-(void)ClearHistoryAll;
/****** History methods ******/

@end

#endif /* DBsqlite_h */
