//
//  DBModelPrivate.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/23.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#ifndef DBModelPrivate_h
#define DBModelPrivate_h

// ========== class:BLE_Devices==========
@interface BLE_Devices ()
+ (NSString *) getTableName;
+ (NSString *) getFieldLeftKneeUpper;
+ (NSString *) getFieldLeftKneeLower;
+ (NSString *) getFieldRightKneeUpper;
+ (NSString *) getFieldRightKneeLower;
+ (NSString *) getAllField;
+ (NSInteger) getAllFieldNum;
- (NSMutableArray *) getVarList;
@end
// ========== class:IMU==========
@interface IMU ()
+ (NSString *) getTableLeftUpper;
+ (NSString *) getTableLeftLower;
+ (NSString *) getTableRightUpper;
+ (NSString *) getTableRightLower;
+ (NSString *) getFieldTime;
+ (NSString *) getFieldSensor:(int)ind;
+ (NSString *) getAllField;
+ (NSInteger) getAllFieldNum;
- (NSMutableArray *) getVarList;
@end
// ========== class:IMU_Correction==========
@interface IMU_Correction ()
+ (NSString *) getTableName;
+ (NSString *) getFieldType;
+ (NSString *) getFieldRelateTime;
+ (NSString *) getFieldSensor:(int)ind;
+ (NSString *) getAllField;
+ (NSInteger) getAllFieldNum;
- (NSMutableArray *) getVarList;
@end
// ========== class:History==========
@interface History ()
+ (NSString *) getTableName;
+ (NSString *) getFieldType;
+ (NSString *) getFieldStartTime;
+ (NSString *) getFieldFinishTime;
+ (NSString *) getFieldRelateTime;
+ (NSString *) getAllField;
+ (NSInteger) getAllFieldNum;
- (NSMutableArray *) getVarList;
@end



#endif /* DBModelPrivate_h */
