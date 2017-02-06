//
//  QueryVC.m
//  SafePlay_DataBase
//
//  Created by garytan on 2017/1/24.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "BLEQueryVC.h"
#import "BLECustomCell.h"
@interface BLEQueryVC (){
    NSMutableArray *array;
}

@end

@implementation BLEQueryVC
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    array=[[NSMutableArray alloc]init];
    array=[self.sqlite GetBLEAll];
    [self.tableView setContentInset:UIEdgeInsetsMake(20,self.tableView.contentInset.left,self.tableView.contentInset.bottom,self.tableView.contentInset.right)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Count:%lu" ,(unsigned long)[array count]);
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"cellForRowAtIndexPath");
    static NSString *cellidentifier=@"cell";
    BLECustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell==nil){
        cell=[[BLECustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    BLE_Devices *ble=[array objectAtIndex:indexPath.row];
    cell.leftlower.text=ble.leftknee_lowerimu;
    cell.leftupper.text=ble.leftknee_upperimu;
    cell.rightupper.text=ble.rightknee_upperimu;
    cell.rightlower.text=ble.rightknee_lowerimu;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
