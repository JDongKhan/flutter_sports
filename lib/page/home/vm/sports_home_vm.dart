import 'package:flutter_sports/base/base_refresh_list_controller.dart';
import 'package:flutter_sports/network/network_utils.dart';

import '../model/sports_content.dart';

/// @author jd

class SportsHomeVm extends BaseRefreshListController<SportsContent> {
  @override
  Future<List<SportsContent>> loadData() async {
    NetworkResponse response = await Network.get(
        'http://baidu.com/sports_infomation_list.do',
        mock: true);
    List list = response.data;
    List<SportsContent> contentList =
        list.map((e) => SportsContent.fromJson(e)).toList();
    return contentList;
  }
}
