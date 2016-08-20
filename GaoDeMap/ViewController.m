
#import "ViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "REVClusterMapView.h"
#import "REVClusterMap.h"
#import "MyAnnotationView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<MKMapViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MKAnnotation>
{
    REVClusterMapView *_mapview;
    
    NSMutableArray *dataArray;
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    
    UITableView *_tableview;
    UIView  *downview;
    
    UILabel *lbl_projecttitle;//工程名称
    UILabel *lbl_address;//地址
    UILabel *lbl_total;//总价钱
    UILabel *lbl_stage;//阶段
    UILabel *lbl_cycle;//周期
    UILabel *lbl_square;//面积
    UILabel *lbl_updatetime;//更新时间
}
@property (nonatomic ,strong) NSDictionary *listDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:27/255.0 green:74/255.0 blue:70/255.0 alpha:1.000]];
    
    dataArray       = [[NSMutableArray alloc] init];
    
    [self addnavigationitem];
    
    [self addMapViewAndeAnnotations];
    
    [self addtableview];
    
    [self adddownview];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addnavigationitem
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索"];
    [self.navigationController.navigationBar.topItem setTitleView:mySearchBar];
    
}

- (void)addMapViewAndeAnnotations
{
    CGRect viewframe        = [[UIScreen mainScreen] applicationFrame];
    _mapview                = [[REVClusterMapView alloc] initWithFrame:viewframe];
    _mapview.delegate       = self;
    [self.view addSubview:_mapview];
    
    //广州市经纬度中心点
    CLLocationCoordinate2D coordinate;
    coordinate.latitude     = 23.117055306224895;
    coordinate.longitude    = 113.2759952545166;
    _mapview.region         = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000);
    
    NSBundle *bundle        = [NSBundle mainBundle];
    NSURL *listurl          = [bundle URLForResource:@"MapLabeling" withExtension:@"plist"];
    NSDictionary *dict      = [NSDictionary dictionaryWithContentsOfURL:listurl];
    self.listDict           = dict;
    NSMutableArray *pins    = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dict count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%i",i+1];
        NSDictionary *tmpdic = [dict objectForKey:key];
        
        REVClusterPin *pin  = [[REVClusterPin alloc] init];
        pin.title           = [tmpdic objectForKey:@"name"];
        pin.subtitle        = [tmpdic objectForKey:@"address"];
        CLLocationCoordinate2D coord    = {[[tmpdic objectForKey:@"lat"] doubleValue],[[tmpdic objectForKey:@"lon"] doubleValue]};
        pin.coordinate      = coord;
        
        [pins addObject:pin];
        [dataArray addObject:pin.title];
    }
    
    [_mapview addAnnotations:pins];
    
}

- (void)addtableview
{
    _tableview              = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    _tableview.delegate     = self;
    _tableview.dataSource   = self;
    _tableview.hidden       = YES;
    [self.view addSubview:_tableview];
    
}


- (void)adddownview
{
    //底部view
    downview                    = [[UIView alloc] init];
    downview.frame              = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
    downview.backgroundColor    = [UIColor whiteColor];
    //项目名称
    lbl_projecttitle            = [[UILabel alloc] init];
    lbl_projecttitle.frame      = CGRectMake(8, 10, kScreenWidth, 20);
    lbl_projecttitle.text       = @"啦啦啦啦啦啦啦啦啦输变电安装";
    lbl_projecttitle.textColor  = [UIColor blueColor];
    lbl_projecttitle.font       = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [downview addSubview:lbl_projecttitle];
    //地址：
    UILabel *add                = [[UILabel alloc] init];
    add.frame                   = CGRectMake(8,
                                             lbl_projecttitle.frame.origin.y +lbl_projecttitle.frame.size.height + 4,
                                             25, 12);
    add.text                    = @"地址:";
    add.textColor               = [UIColor blackColor];
    add.font                    = [UIFont  systemFontOfSize:10.0];
    [downview addSubview:add];
    //详细地址
    lbl_address                 = [[UILabel alloc] init];
    lbl_address.frame           = CGRectMake(add.frame.origin.x + add.frame.size.width + 10,
                                             add.frame.origin.y,
                                             kScreenWidth - add.frame.origin.x + add.frame.size.width +20,
                                             12);
    lbl_address.text            = @"广州市番禺区番禺大道北555号天安节能科技园总部1号楼405";
    lbl_address.textColor       = [UIColor blackColor];
    lbl_address.font            = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_address];
    //造价
    UILabel *total              = [[UILabel alloc] init];
    total.frame                 = CGRectMake(8,
                                             add.frame.origin.y +add.frame.size.height + 4,
                                             25, 12);
    total.text                  = @"造价:";
    total.textColor             = [UIColor blackColor];
    total.font                  = [UIFont  systemFontOfSize:10.0];
    [downview addSubview:total];
    //造价金额
    lbl_total                   = [[UILabel alloc] init];
    lbl_total.frame             = CGRectMake(lbl_address.frame.origin.x,
                                             total.frame.origin.y,
                                             100,
                                             12);
    lbl_total.text              = @"300亿";
    lbl_total.textColor         = [UIColor blackColor];
    lbl_total.font              = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_total];
    //阶段：
    UILabel *stage              = [[UILabel alloc] init];
    stage.frame                 = CGRectMake(8,
                                             total.frame.origin.y +total.frame.size.height + 4,
                                             25, 12);
    stage.text                  = @"阶段:";
    stage.textColor             = [UIColor blackColor];
    stage.font                  = [UIFont  systemFontOfSize:10.0];
    [downview addSubview:stage];
    //阶段详情
    lbl_stage                   = [[UILabel alloc] init];
    lbl_stage.frame             = CGRectMake(lbl_total.frame.origin.x,
                                             stage.frame.origin.y,
                                             120,
                                             12);
    lbl_stage.text              = @"主题工程";
    lbl_stage.textColor         = [UIColor blackColor];
    lbl_stage.font              = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_stage];
    //建设周期
    UILabel *cycle              = [[UILabel alloc] init];
    cycle.frame                 = CGRectMake(8,
                                             stage.frame.origin.y +stage.frame.size.height + 4,
                                             60, 12);
    cycle.text                  = @"建设周期:";
    cycle.textColor             = [UIColor blackColor];
    cycle.font                  = [UIFont  systemFontOfSize:10.0];
    [downview addSubview:cycle];
    //周期详情
    lbl_cycle                   = [[UILabel alloc] init];
    lbl_cycle.frame             = CGRectMake(cycle.frame.origin.x+cycle.frame.size.width + 5,
                                             cycle.frame.origin.y,
                                             120,
                                             12);
    lbl_cycle.text              = @"2014-12-01至2018-12-01";
    lbl_cycle.textColor         = [UIColor blackColor];
    lbl_cycle.font              = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_cycle];
    
    //面积
    UILabel *square             = [[UILabel alloc] init];
    square.frame                = CGRectMake(lbl_total.frame.origin.x + lbl_total.frame.size.width + 40,
                                             lbl_total.frame.origin.y,
                                             60, 12);
    square.text                 = @"建筑面积:";
    square.textColor            = [UIColor blackColor];
    square.font                 = [UIFont systemFontOfSize:10.0];
    [downview addSubview:square];
    
    lbl_square                  = [[UILabel alloc] init];
    lbl_square.frame            = CGRectMake(square.frame.origin.x +square.frame.size.width +5,
                                             square.frame.origin.y, 100, 12);
    lbl_square.text             = @"10000平方米";
    lbl_square.textColor        = [UIColor blackColor];
    lbl_square.font             = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_square];
    
    //更新时间
    UILabel *updatetime         = [[UILabel alloc] init];
    updatetime.frame            = CGRectMake(square.frame.origin.x,
                                             square.frame.origin.y +square.frame.size.height + 4, 60, 12);
    updatetime.text             = @"更新时间:";
    updatetime.textColor        = [UIColor blackColor];
    updatetime.font             = [UIFont systemFontOfSize:10.0];
    [downview addSubview:updatetime];
    
    lbl_updatetime              = [[UILabel alloc] init];
    lbl_updatetime.frame        = CGRectMake(lbl_square.frame.origin.x,
                                             updatetime.frame.origin.y,
                                             120, 12);
    lbl_updatetime.text         = @"2015-10-20";
    lbl_updatetime.textColor    = [UIColor blackColor];
    lbl_updatetime.font         = [UIFont systemFontOfSize:10.0];
    [downview addSubview:lbl_updatetime];
    
    [downview setHidden:YES];
    [self.view addSubview:downview];
    
    
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation class] == MKUserLocation.class) {
        //userLocation = annotation;
        return nil;
    }
    
    REVClusterPin *pin = (REVClusterPin *)annotation;
    
    MKAnnotationView *annView;
    
    if( [pin nodeCount] > 0 ){
        annView = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"cluster"];
        
        if( !annView )
            annView = (MyAnnotationView *)[[MyAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"cluster"];
        
        annView.image = [UIImage imageNamed:@"cluster.png"];
        [(MyAnnotationView *)annView setClusterText:[NSString stringWithFormat:@"%lu",(unsigned long)[pin nodeCount]]];
        annView.canShowCallout = YES;
    } else {
        annView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        
        if( !annView )
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"] ;
        
        annView.image = [UIImage imageNamed:@"iconfont-mark.png"];
        annView.canShowCallout = YES;
    }
    
    
    
    return annView;
    
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [_tableview reloadData];
        [_tableview setHidden:YES];
    }else
    {
        searchResults = [[NSMutableArray alloc]init];
        if (mySearchBar.text.length>0&&![ChineseInclude inIncludeChineseInString:   mySearchBar.text]) {
            for (int i=0; i<dataArray.count; i++) {
                if ([ChineseInclude inIncludeChineseInString:dataArray[i]]) {
                    NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
                    NSRange titleResult=[tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [searchResults addObject:dataArray[i]];
                    }
                    NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
                    NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleHeadResult.length>0) {
                        [searchResults addObject:dataArray[i]];
                    }
                }
                else {
                    NSRange titleResult=[dataArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                    if (titleResult.length>0) {
                        [searchResults addObject:dataArray[i]];
                    }
                }
            }
            
        } else if (mySearchBar.text.length>0&&[ChineseInclude inIncludeChineseInString:mySearchBar.text]) {
            for (NSString *tempStr in dataArray) {
                NSRange titleResult=[tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:tempStr];
                }
            }
        }
        
        [_tableview reloadData];
        [_tableview setHidden:NO];
    }
    
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [downview setHidden:NO];
    
    //获取标题和副标题
    REVClusterPin *pin = (REVClusterPin *)(view.annotation);
    //获取view
    //    MyAnnotationView *annview = (MyAnnotationView*)view;
    //    NSLog(@"lat=%f",annview.coordinate.latitude);
    //    NSLog(@"lon=%f",annview.coordinate.longitude);
    
    lbl_projecttitle.text = pin.title;
    lbl_address.text      = pin.subtitle;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchResults.count;
    
}
//返回每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = searchResults[indexPath.row];
    
    
    return cell;
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < [self.listDict count]; i++) {
        NSString *key                       = [[NSString alloc] initWithFormat:@"%i",i+1];
        NSDictionary *tmpdic                = [self.listDict objectForKey:key];
        if ([searchResults[indexPath.row] isEqualToString:[tmpdic objectForKey:@"name"]]) {
            REVClusterPin *pin              = [[REVClusterPin alloc] init];
            CLLocationCoordinate2D coord    = {[[tmpdic objectForKey:@"lat"] doubleValue],[[tmpdic objectForKey:@"lon"] doubleValue]};
            pin.coordinate                  = coord;
            _mapview.region                 = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
            _tableview.hidden               = YES;
            break;
        }
    }
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mySearchBar resignFirstResponder];
    
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_mapview removeAnnotations:_mapview.annotations];
    _mapview.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end