//
//  IMU_CorrectionQueryVC.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/25.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "IMU_CorrectionQueryVC.h"
#import "CorrectionCustomCell.h"
@interface IMU_CorrectionQueryVC (){
    NSMutableArray *array;
}

@end

@implementation IMU_CorrectionQueryVC

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"viewDidLoad");
    array=[self.sqlite GetIMUCorrectionAll:@"time"];
    NSLog(@"arraycount%@",@([array count]));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%@",@([array count]));
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cellForRowAtIndexPath");
    static NSString *cellidentifier=@"cell";
    CorrectionCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell==nil){
        cell=[[CorrectionCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    IMU_Correction *imucorrection=[array objectAtIndex:indexPath.row];
    for(int i=0;i<9;i++){
        [[cell.IMUS objectAtIndex:(i)] setText:[NSString stringWithFormat:@"%d", imucorrection.imu[i]]];
        NSLog(@"IMU::::%d",imucorrection.imu[i]);
    }
    cell.relate_time.text=imucorrection.datetime;
    NSString *Type_String = [NSString stringWithFormat:@"%d",imucorrection.type];
    cell.type.text=Type_String;
    return cell;
    
}

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
