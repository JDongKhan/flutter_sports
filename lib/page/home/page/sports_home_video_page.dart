import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sports/utils/asset_bundle_utils.dart';
import 'package:flutter_tracker_widget/flutter_tracker_widget.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';

import '../../../utils/screen_utils.dart';
import '../../../widgets/direction_button.dart';
import '../../live/sports_live_detail_page.dart';
import '../model/sports_video.dart';
import '../vm/sports_home_video_vm.dart';
import '../vm/sports_tab_home_vm.dart';
import '../widget/sports_list_player.dart';

/// @author jd

class SportsHomeVideoPage extends StatefulWidget {
  @override
  _SportsHomeVideoPageState createState() => _SportsHomeVideoPageState();
}

class _SportsHomeVideoPageState extends State<SportsHomeVideoPage>
    with AutomaticKeepAliveClientMixin, LifecycleAware, LifecycleMixin {
  final ScrollController _scrollController = ScrollController();
  SportsHomeVideoVM vm = Get.put(SportsHomeVideoVM());
  SportsTabHomeVM sportsTabHomeVM = Get.find<SportsTabHomeVM>();
  Map<int, SportsListPlayerController> _playerController =
      <int, SportsListPlayerController>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _playerController.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SportsHomeVideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SportsHomeVideoVM>(
        assignId: true,
        builder: (vm) {
          return Container(
            color: Colors.black,
            child: TrackerScrollWidget(
              hitViewPortCondition: (
                double deltaTop,
                double deltaBottom,
                double viewPortDimension,
              ) {
                print(
                    'deltaTop:$deltaTop - deltaBottom:$deltaBottom - viewPortDimension:$viewPortDimension');
                return deltaTop < (0.5 * viewPortDimension) &&
                    deltaBottom > (0.5 * viewPortDimension);
              },
              initHitIds: const <String>['0'],
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return TrackerItemWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget? Child) {
                      index = index % 5;
                      SportsVideo video = vm.data[index];
                      print('index:$index - isInView:$isInView');
                      SportsListPlayerController? controller =
                          _playerController[index];
                      if (controller == null) {
                        controller = SportsListPlayerController(
                            videoUrl: video.videoUrl ?? '');
                        _playerController[index] = controller;
                      }
                      return _buildItem(video, isInView, controller);
                    },
                  );
                },
                itemCount: vm.data.length * 5,
              ),
            ),
          );
        });
  }

  Widget _buildItem(SportsVideo video, bool isPlaying,
      SportsListPlayerController controller) {
    List<Widget> columnChildren = [];

    ///个人信息
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              AssetBundleUtils.getImgPath(video.face),
              width: 40,
              height: 40,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: Text(
              video.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              video.foucs == '1' ? '已关注' : '关注',
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Color(0xffaaaaaa),
            ),
          ),
        ],
      ),
    ));

    ///title
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        video.title ?? '',
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

    ///播放器
    columnChildren.add(Container(
      width: get_screenWidth(),
      height: get_screenWidth() / 16 * 9,
      child: SportsListPlayer(
        cover: video.cover ?? '',
        videoUrl: video.videoUrl ?? '',
        playing: isPlaying,
        sportsListPlayerController: controller,
      ),
    ));

    ///关键词
    if (video.searchKeywork != null && (video.searchKeywork ?? '').isNotEmpty) {
      columnChildren.add(Container(
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                video.searchKeywork ?? '',
                style: const TextStyle(
                  color: Color(0xffaaaaaa),
                  fontSize: 13,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 14,
              color: Color(0xffaaaaaa),
            ),
          ],
        ),
      ));
    }

    ///点赞
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DirectionButton(
            icon: const Icon(
              Icons.share,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: const Text(
              '分享',
              style: TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('分享'),
                      content: const Text('确定分享吗?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('确认'),
                        ),
                      ],
                    );
                  });
            },
          ),
          DirectionButton(
            icon: const Icon(
              Icons.favorite,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: const Text(
              '收藏',
              style: TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
          DirectionButton(
            icon: const Icon(
              Icons.comment_bank_outlined,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: Text(
              video.commentNum ?? '评论',
              style: const TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
          DirectionButton(
            icon: const Icon(
              Icons.thumb_up_alt_outlined,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: Text(
              video.thumbs ?? '赞',
              style: const TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
        ],
      ),
    ));
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SportsLiveDetailPage(
              videoUrl: video.videoUrl ?? '',
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: columnChildren,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.push) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        sportsTabHomeVM.changAppBarBackgroundColor(Colors.black);
      });
    } else if (event == LifecycleEvent.visible) {
      sportsTabHomeVM.changAppBarBackgroundColor(Colors.black);
    } else if (event == LifecycleEvent.invisible) {
      if (mounted) {
        sportsTabHomeVM.changAppBarBackgroundColor(Colors.blue);
      }
    } else if (event == LifecycleEvent.active) {
    } else if (event == LifecycleEvent.inactive) {
    } else if (event == LifecycleEvent.pop) {}
  }
}
