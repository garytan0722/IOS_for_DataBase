//
//  DBsqlite.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBsqlite.h"
#import "DBModelsPrivate.h"
@interface DBsqlite(){
    dispatch_queue_t serialQueue;
    dispatch_group_t serialGroup;
}
- (NSString *) generateMutipleQuestion:(NSInteger)num;
- (NSMutableArray *) ParsingBLEQueryArray:(FMResultSet *)rs;
- (NSMutableArray *) ParsingHistoryQueryArray:(FMResultSet *)rs;
//IMU methods
- (BOOL) AddIMUAllHelper:(NSMutableArray *)data table:(NSString *)tableName;
- (NSMutableArray *) GetIMUHelper:(NSString *)time table:(NSString *)tableName;
- (void) ClearAllUpperIMULeft;
- (void) ClearAllLowerIMULeft;
- (void) ClearAllUpperIMURIght;
- (void) ClearAllLowerIMURIght;
//IMU_Correction
- (BOOL) AddIMUCorrectionAllHelper:(NSMutableArray *)data table:(NSString *)tableName;
- (NSMutableArray *) GetIMUCorrectionHelper:(NSString *)relate_time table:(NSString *)tableName;
@end

@implementation DBsqlite

/****** private methods ******/
- (NSString *) generateMutipleQuestion:(NSInteger)num
{
    if( num == 0 )
        return @"()";
    
    NSMutableString * ret = [[NSMutableString alloc] initWithString:@"(?"];
    for(int i=1; i<num; i+=1)
    {
        [ret appendString:@", ?"];
    }
    [ret appendString:@")"];
    
    return ret;
}
/****** private methods ******/


/****** public and init methods ******/

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        serialQueue = dispatch_queue_create("com.ideas.safeplay", NULL);
        serialGroup = dispatch_group_create();
        
        //將資料庫檔案複製到具有寫入權限的目錄
        NSFileManager *fm = [[NSFileManager alloc]init];
        NSString *src = [[NSBundle mainBundle]pathForResource:@"safeplay" ofType:@"sqlite"];
        NSString *dst = [NSString stringWithFormat:@"%@/Documents/safeplay.sqlite",NSHomeDirectory()];
        
        //APP啓用的時候在@/Documents 沒有資料庫，所以要從APP裡面把sample.sqlite資料庫拷貝到 @/Documents/ 資料夾下
        if(![fm fileExistsAtPath:dst])
        {
            //把資料庫複製到 Documents/db 資料夾下
            [fm removeItemAtPath:dst error:nil];
            [fm copyItemAtPath:src toPath:dst error:nil];
            NSLog(@"建立新資料庫！");
        }
        else
        {
            //            [fm removeItemAtPath:dst error:nil];
            //            [fm copyItemAtPath:src toPath:dst error:nil];
            NSLog(@"使用原有資料庫！");
        }
        
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName=[doc stringByAppendingPathComponent:@"safeplay.sqlite"];
        
        NSLog(@"%@", fileName);
        
        //2.獲得database
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        
        //3.打開database
        if( queue == nil )
        {
            NSLog(@"資料庫連線失敗");
        }
        else
        {
            NSLog(@"資料庫連線成功");
            self.queue = queue;
        }
    }
    
    return self;
}
- (instancetype)initWithNewDatabase
{
    self = [super init];
    if (self)
    {
        serialQueue = dispatch_queue_create("com.ideas.safeplay", NULL);
        serialGroup = dispatch_group_create();
        
        //將資料庫檔案複製到具有寫入權限的目錄
        NSFileManager *fm = [[NSFileManager alloc]init];
        NSString *src = [[NSBundle mainBundle]pathForResource:@"safeplay" ofType:@"sqlite"];
        NSString *dst = [NSString stringWithFormat:@"%@/Documents/safeplay.sqlite",NSHomeDirectory()];
        
        //APP啓用的時候在@/Documents 沒有資料庫，所以要從APP裡面把sample.sqlite資料庫拷貝到 @/Documents/ 資料夾下
        
        //把資料庫複製到 Documents 資料夾下
        [fm removeItemAtPath:dst error:nil];
        [fm copyItemAtPath:src toPath:dst error:nil];
        NSLog(@"建立新資料庫！");
        
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName=[doc stringByAppendingPathComponent:@"safeplay.sqlite"];
        
        NSLog(@"%@", fileName);
        
        //2.獲得database
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        
        //3.打開database
        
        if( queue == nil )
        {
            NSLog(@"資料庫連線失敗");
        }
        else
        {
            NSLog(@"資料庫連線成功");
            self.queue = queue;
        }
    }
    
    return self;
}

 /****** public and init methods ******/
- (void) Realease
{
    //    [self.db close];
    [self.queue close];
}
- (NSMutableArray *) ParsingBLEQueryArray:(FMResultSet *)rs{
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    
    while( [rs next] )
    {
        BLE_Devices * ble = [[BLE_Devices alloc] init];
        ble.leftknee_upperimu = [rs stringForColumn:[BLE_Devices getFieldLeftKneeUpper]];
        ble.leftknee_lowerimu = [rs stringForColumn:[BLE_Devices getFieldLeftKneeLower]];
        ble.rightknee_upperimu = [rs stringForColumn:[BLE_Devices getFieldRightKneeUpper]];
        ble.rightknee_lowerimu = [rs stringForColumn:[BLE_Devices getFieldRightKneeLower]];
        [ret addObject:ble];
    }
    
    return ret;
}
- (NSMutableArray *) ParsingHistoryQueryArray:(FMResultSet *)rs{
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    
    while( [rs next] )
    {
        History * history = [[History alloc] init];
        history.type = [rs intForColumn:[History getFieldType]];
        history.start_time = [rs stringForColumn:[History getFieldStartTime]];
        history.finish_time = [rs stringForColumn:[History getFieldFinishTime]];
        history.relate_time = [rs stringForColumn:[History getFieldRelateTime]];
        [ret addObject:history];
    }
    return ret;
}
/****** BLE_Devices methods ******/
- (BOOL) AddBLE:(BLE_Devices *) newBLE
{
    NSLog(@"AddBLE");
    __block BOOL succ;
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        succ = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ %@ VALUES %@", [BLE_Devices getTableName], [BLE_Devices getAllField], [self generateMutipleQuestion:[BLE_Devices getAllFieldNum]]]
            withArgumentsInArray:[newBLE getVarList]];
        
        if(!succ)
        {
            NSLog(@"Errrrrororor:%@", [db lastErrorMessage]);
            *rollback = YES;
            return;
        }
    }];
    
    return succ;
}
- (NSMutableArray *) GetBLEAll
{
    NSLog(@"GetAllBLE");
    __block NSMutableArray * ret;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", [BLE_Devices getTableName]]];
        
        ret = [self ParsingBLEQueryArray:rs];
    }];
    
    return ret;
}
-(void)ClearBLEAll{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [BLE_Devices getTableName]]];
    }];

}
/****** BLE_Devices methods ******/

/****** IMU methods ******/
- (BOOL) AddIMUAllHelper:(NSMutableArray *)data table:(NSString *)tableName
{
    dispatch_group_async(serialGroup, serialQueue, ^(void) {
        __block BOOL succ;
        [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for(int i=0; i<[data count]; i+=1) {
                succ = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ %@ VALUES %@", tableName, [IMU getAllField], [self generateMutipleQuestion:[IMU getAllFieldNum]]]
                    withArgumentsInArray:[data[i] getVarList]];
                if( !succ )
                {
                    NSLog(@"Errrrrororor:%@", [db lastErrorMessage]);

                    *rollback = true;
                    return;
                }
            }
        }];
    });
    
    
    return YES;
}
- (BOOL) AddUpperIMULeftAll:(NSMutableArray *)data
{
    return [self AddIMUAllHelper:data table:[IMU getTableLeftUpper]];
}

- (BOOL) AddLowerIMULeftAll:(NSMutableArray *)data
{
    return [self AddIMUAllHelper:data table:[IMU getTableLeftLower]];
}

- (BOOL) AddUpperIMURightAll:(NSMutableArray *)data
{
    return [self AddIMUAllHelper:data table:[IMU getTableRightUpper]];
}

- (BOOL) AddLowerIMURightAll:(NSMutableArray *)data
{
    return [self AddIMUAllHelper:data table:[IMU getTableRightLower]];
}
- (NSMutableArray *) GetUpperIMULeft:(NSString *)time
{
    return [self GetIMUHelper:time table:[IMU getTableLeftUpper]];
}

- (NSMutableArray *) GetLowerIMULeft:(NSString *)time
{
    return [self GetIMUHelper:time table:[IMU getTableLeftLower]];
}

- (NSMutableArray *) GetUpperIMURight:(NSString *)time
{
    return [self GetIMUHelper:time table:[IMU getTableRightUpper]];
}

- (NSMutableArray *) GetLowerIMURight:(NSString *)time
{
    return [self GetIMUHelper:time table:[IMU getTableRightLower]];
}
- (NSMutableArray *) GetIMUHelper:(NSString *)time table:(NSString *)tableName
{
    __block NSMutableArray * ret = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ ", tableName, [IMU getFieldTime]]];
        
        while( [rs next] )
        {
            IMU * imu = [[IMU alloc] init];
            imu.datetime = [rs stringForColumn:[IMU getFieldTime]];
            for(int i=0; i<[IMU getIMUSize]; i+=1)
            {
                imu.imu[i] = [rs intForColumn:[IMU getFieldSensor:i]];
            }
            
            [ret addObject:imu];
        }
    }];
    return ret;
}
- (void) ClearAllUpperIMULeft
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [IMU getTableLeftUpper]]];
    }];
}

- (void) ClearAllLowerIMULeft
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [IMU getTableLeftLower]]];
    }];
}

- (void) ClearAllUpperIMURIght
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [IMU getTableRightUpper]]];
    }];
}

- (void) ClearAllLowerIMURIght
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [IMU getTableRightLower]]];
    }];
}

- (void) ClearAllIMU
{
    [self ClearAllUpperIMULeft];
    [self ClearAllLowerIMULeft];
    [self ClearAllUpperIMURIght];
    [self ClearAllLowerIMURIght];
}
/****** IMU methods ******/

/****** IMU Correction methods ******/
- (BOOL) AddIMUCorrectionAll:(NSMutableArray *)data{
    NSLog(@"AddIMUCorrectionAll %@",@([data count]));
    return [self AddIMUCorrectionAllHelper:data table:[IMU_Correction getTableName]];
}
- (BOOL) AddIMUCorrectionAllHelper:(NSMutableArray *)data table:(NSString *)tableName
{
    dispatch_group_async(serialGroup, serialQueue, ^(void) {
        __block BOOL succ;
        [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for(int i=0; i<[data count]; i+=1) {
                succ = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ %@ VALUES %@", tableName, [IMU_Correction getAllField], [self generateMutipleQuestion:[IMU_Correction getAllFieldNum]]]
                    withArgumentsInArray:[data[i] getVarList]];
                if( !succ )
                {
                    NSLog(@"Errrrrororor:%@", [db lastErrorMessage]);
                    
                    *rollback = true;
                    return;
                }
            }
        }];
    });
    
    return YES;
}

- (NSMutableArray *) GetIMUCorrectionAll:(NSString *)relate_time
{
    return [self GetIMUCorrectionHelper:relate_time table:[IMU_Correction getTableName]];
}
- (NSMutableArray *) GetIMUCorrectionHelper:(NSString *)relate_time table:(NSString *)tableName
{
    __block NSMutableArray * ret = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ ", tableName, [IMU_Correction getFieldRelateTime]]];
        
        while( [rs next] )
        {
            IMU_Correction * imucorrection = [[IMU_Correction alloc] init];
            imucorrection.datetime = [rs stringForColumn:[IMU_Correction getFieldRelateTime]];
            imucorrection.type=[rs intForColumn:[IMU_Correction getFieldType]];
            for(int i=0; i<[IMU_Correction getIMUSize]; i+=1)
            {
                imucorrection.imu[i] = [rs intForColumn:[IMU_Correction getFieldSensor:i]];
            }
            
            [ret addObject:imucorrection];
        }
    }];
    NSLog(@"Select Array%@",@([ret count]));
    return ret;
}
- (void) ClearAllIMUCorrection
{
    NSLog(@"ClearAllIMUCorrection");
    dispatch_group_async(serialGroup, serialQueue, ^(void) {
        __block BOOL succ;
        [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
          succ=[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [IMU_Correction getTableName]]];
                if( !succ )
                {
                    NSLog(@"Errrrrororor:%@", [db lastErrorMessage]);
                    *rollback = true;
                }
        }];
    });
}
/****** IMU Correction methods ******/

/****** History methods ******/
- (BOOL) AddHistoryAll:(History *)newHistory{
    NSLog(@"AddHistory");
    __block BOOL succ;
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        succ = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ %@ VALUES %@", [History getTableName], [History getAllField], [self generateMutipleQuestion:[History getAllFieldNum]]]
            withArgumentsInArray:[newHistory getVarList]];
        if(!succ)
        {
            NSLog(@"Errrrrororor:%@", [db lastErrorMessage]);
            *rollback = YES;
            return;
        }
    }];
    return succ;
}
- (NSMutableArray *) GetHistoryAll
{
    NSLog(@"GetHistoryAll");
    __block NSMutableArray * ret;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", [History getTableName]]];
        
        ret = [self ParsingHistoryQueryArray:rs];
    }];
    
    return ret;
}
- (void) ClearHistoryAll
{
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", [History getTableName]]];
    }];
}
/****** History methods ******/
@end
