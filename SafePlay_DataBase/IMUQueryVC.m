//
//  IMUQueryVC.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "IMUQueryVC.h"
#import "IMUCustomCell.h"
@interface IMUQueryVC (){
    NSMutableArray  *array,*UpperIMULeft,*UpperIMURight,*LowerLeft,*LowerRight;

}


@end

@implementation IMUQueryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IMUviewDidLoad");
    array=[[NSMutableArray alloc]init];
    UpperIMULeft=[[NSMutableArray alloc]init];
    UpperIMURight=[[NSMutableArray alloc]init];
    LowerLeft=[[NSMutableArray alloc]init];
    LowerRight=[[NSMutableArray alloc]init];
    UpperIMULeft=[self.sqlite GetUpperIMULeft:@"time"];
    UpperIMURight=[self.sqlite GetUpperIMURight:@"time"];
    LowerLeft=[self.sqlite GetLowerIMULeft:@"time"];
    LowerRight=[self.sqlite GetLowerIMURight:@"time"];
     NSLog(@"IMUviewDidLoad%@",@([UpperIMULeft count]));
    for(int i=0;i<[UpperIMULeft count];i++){
        [array addObject:[UpperIMULeft objectAtIndex:(i)]];
        [array addObject:[UpperIMURight objectAtIndex:(i)]];
        [array addObject:[LowerLeft objectAtIndex:(i)]];
        [array addObject:[LowerRight objectAtIndex:(i)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *cellidentifier=@"customcell";
    IMUCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell==nil){
        cell=[[IMUCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    NSLog(@"Array Count:%@",@([array count]));
    IMU *imu=[array objectAtIndex:indexPath.row];
       for(int i=0;i<9;i++){
        [[cell.IMUS objectAtIndex:(i)] setText:[NSString stringWithFormat:@"%d", imu.imu[i]]];
        NSLog(@"IMU::::%d",imu.imu[i]);
    }
    cell.time.text=imu.datetime;
    return cell;

}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
