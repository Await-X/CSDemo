//

#import "XPFUploadProductCell.h"

@interface XPFUploadProductCell ()

@end

@implementation XPFUploadProductCell

///
+ (XPFUploadProductCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"XPFUploadProductCell%ld%ld", (long)indexPath.section, (long)indexPath.row];
    XPFUploadProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[XPFUploadProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    XPFUploadProductCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//    if (cell == nil) {
//        cell = [[XPFUploadProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    return cell;
}
///
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    indexPath:(NSIndexPath *)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
