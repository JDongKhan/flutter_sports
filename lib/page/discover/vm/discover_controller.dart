import '../../../base/base_common_controller.dart';

/// @author jd

class DiscoverController extends BaseCommonController {
  int currentIndex = 0;

  ///用map代替model
  final List<Map<String, dynamic>> moduleList = <Map<String, dynamic>>[
    ///demo
    {
      'title': 'Demo',
      'items': [
        {
          'title': '抖音',
          'router': '/douyin',
        },
        {
          'title': 'Scaffold',
          'router': '/scaffold',
        },
      ],
    },
  ];

  @override
  Future loadData() async {
    return true;
  }

  @override
  void onCompleted(data) {}
}
