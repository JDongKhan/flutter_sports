import 'package:flutter_sports/base/base_refresh_list_controller.dart';

import '../../../network/network_utils.dart';
import '../model/sports_video.dart';

/// @author jd

class SportsHomeVideoVM extends BaseRefreshListController<SportsVideo> {
  @override
  Future<List<SportsVideo>> loadData() async {
    NetworkResponse response =
        await Network.get('http://baidu.com/sports_video_list.do', mock: true);
    List list = response.data;
    List<SportsVideo> contentList =
        list.map((e) => SportsVideo.fromJson(e)).toList();
    return contentList;
  }
}
