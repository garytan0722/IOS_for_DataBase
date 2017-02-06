//
//  DBModels.h
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/23.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#ifndef DBModels_h
#define DBModels_h
//------BLE Object-------
@interface BLE_Devices : NSObject
@property (strong, nonatomic) NSString * leftknee_upperimu;
@property (strong, nonatomic) NSString * rightknee_upperimu;
@property (strong, nonatomic) NSString * leftknee_lowerimu;
@property (strong, nonatomic) NSString * rightknee_lowerimu;
@end
//------BLE Object-------
//------IMU-------
@interface IMU : NSObject
@property (strong, nonatomic) NSString * datetime;
@property (nonatomic) int * imu;
+ (int) getIMUSize;
@end
//------IMU_Correction-------
@interface IMU_Correction : NSObject
@property (nonatomic) int type;
@property (nonatomic) int * imu;
@property (strong, nonatomic) NSString * datetime;
+ (int) getIMUSize;
@end
//------History-------
@interface History : NSObject
@property (nonatomic) int type;
@property (strong, nonatomic) NSString * start_time;
@property (strong, nonatomic) NSString * finish_time;
@property (strong, nonatomic) NSString * relate_time;
@end

#endif /* DBModels_h */
