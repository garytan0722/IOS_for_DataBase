//
//  DBModels.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/23.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBModels.h"
#import "DBModelsPrivate.h"

// ==================== class:BLE ====================

@interface BLE_Devices ()

@end

@implementation BLE_Devices

// ========== private methods ==========

+ (NSString *) getTableName
{
    return @"ble_device";
}

+ (NSString *) getFieldLeftKneeUpper
{
    return @"left_upperimu";
}

+ (NSString *) getFieldLeftKneeLower
{
    return @"left_lowerimu";
}

+ (NSString *) getFieldRightKneeUpper
{
    return @"right_upperimu";
}

+ (NSString *) getFieldRightKneeLower
{
    return @"right_lowerimu";
}

+ (NSString *) getAllField
{
    return @"(left_upperimu,left_lowerimu,right_upperimu,right_lowerimu)";
}

+ (NSInteger) getAllFieldNum
{
    return 4;
}

- (NSMutableArray *) getVarList
{
    NSLog(@"BLEgetVarList");
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    [ret addObject:[self leftknee_upperimu]];
    [ret addObject:[self leftknee_lowerimu]];
    [ret addObject:[self rightknee_upperimu]];
    [ret addObject:[self rightknee_lowerimu]];
    if([ret count] != [BLE_Devices getAllFieldNum])
    {
        NSLog(@"Some of BLE fields missed");
        return nil;
    }
    
    return ret;
}
@end
// ==================== class:IMU ====================
@interface IMU ()
@end

@implementation IMU

// ========== private methods ==========

+ (NSString *) getTableLeftUpper
{
    return @"leftknee_upperimu";
}

+ (NSString *) getTableLeftLower
{
    return @"leftknee_lowerimu";
}

+ (NSString *) getTableRightUpper
{
    return @"rightknee_upperimu";
}

+ (NSString *) getTableRightLower
{
    return @"rightknee_lowerimu";
}
+ (NSString *) getFieldTime
{
    return @"time";
}
+ (NSString *) getFieldSensor:(int)ind
{
    NSArray * strs1 = [[NSArray alloc] initWithObjects:@"accel", @"gyro", @"mag", nil];
    NSArray * strs2 = [[NSArray alloc] initWithObjects:@"x", @"y", @"z", nil];
    NSString * ret = [[NSString alloc] initWithString:strs1[ind/3]];
    return [NSString stringWithFormat:@"%@_%@", ret, strs2[ind%3]];
}

+ (NSString *) getAllField
{
    return @"(time,accel_x,accel_y,accel_z,gyro_x,gyro_y,gyro_z,mag_x,mag_y,mag_z)";
}

+ (NSInteger) getAllFieldNum
{
    return 10;
}

- (NSMutableArray *) getVarList
{
    
    NSMutableArray * ret =  [[NSMutableArray alloc] initWithObjects:self.datetime, nil];
    for(int i=0; i<[IMU getIMUSize]; i+=1)
    {
        [ret addObject:@(self.imu[i])];
    }
    if([ret count] != [IMU getAllFieldNum])
    {
        NSLog(@"Some of KneeIMU fields missed");
        return nil;
    }
    return ret;
}

// ========== public methods ==========
+ (int) getIMUSize
{
    return 9;
}

- (instancetype) init
{
    self = [super init];
    if( self )
    {
        self.imu = malloc([IMU getIMUSize] * sizeof(int));
    }
    return self;
}

@end
// ==================== class:IMU_Correction ====================
@interface IMU_Correction ()
@end
@implementation IMU_Correction
// ========== private methods ==========

+ (NSString *) getTableName
{
    return @"imu_correction";
}
+ (NSString *) getFieldType
{
    return @"type";
}

+ (NSString *) getFieldRelateTime
{
    return @"relate_time";
}
+ (NSString *) getFieldSensor:(int)ind
{
    NSArray * strs1 = [[NSArray alloc] initWithObjects:@"accel", @"gyro", @"mag", nil];
    NSArray * strs2 = [[NSArray alloc] initWithObjects:@"x", @"y", @"z", nil];
    NSString * ret = [[NSString alloc] initWithString:strs1[ind/3]];
    return [NSString stringWithFormat:@"%@_%@", ret, strs2[ind%3]];
}

+ (NSString *) getAllField
{
    return @"(type,relate_time,accel_x,accel_y,accel_z,gyro_x,gyro_y,gyro_z,mag_x,mag_y,mag_z)";
}
+ (NSInteger) getAllFieldNum
{
    return 11;
}

- (NSMutableArray *) getVarList
{
    NSMutableArray * ret =  [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:self.type],self.datetime, nil];
    for(int i=0; i<[IMU_Correction getIMUSize]; i+=1)
    {
        [ret addObject:@(self.imu[i])];
    }
    if([ret count] != [IMU_Correction getAllFieldNum])
    {
        NSLog(@"Some of IMU_Correction fields missed");
        return nil;
    }
    NSLog(@"getVarList arraycount%@",@([ret count]));
    return ret;
}

// ========== public methods ==========
+ (int) getIMUSize
{
    return 9;
}

- (instancetype) init
{
    self = [super init];
    if( self )
    {
        self.imu = malloc([IMU_Correction getIMUSize] * sizeof(int));
    }
    return self;
}
@end

// ==================== class:History ====================
@interface History ()
@end
@implementation History
// ========== private methods ==========

+ (NSString *) getTableName
{
    return @"history";
}
+ (NSString *) getFieldType
{
    return @"type";
}

+ (NSString *) getFieldStartTime
{
    return @"start_time";
}
+ (NSString *) getFieldFinishTime
{
    return @"finish_time";
}
+ (NSString *) getFieldRelateTime
{
    return @"relate_time";
}

+ (NSString *) getAllField
{
    return @"(type,start_time,finish_time,relate_time)";
}
+ (NSInteger) getAllFieldNum
{
    return 4;
}

- (NSMutableArray *) getVarList
{
    NSMutableArray * ret =  [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:self.type], nil];
    [ret addObject:[self start_time]];
    [ret addObject:[self finish_time]];
    [ret addObject:[self relate_time]];
    if([ret count] != [BLE_Devices getAllFieldNum])
    {
        NSLog(@"Some of History fields missed");
        return nil;
    }

    return ret;
}
@end
