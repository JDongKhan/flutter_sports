import 'package:flutter/material.dart';
import 'package:flutter_sports/utils/asset_bundle_utils.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

import '../vm/sports_home_tv_vm.dart';
import '../widget/sports_home_tv_item.dart';
import '../widget/timer_widget.dart';

/// @author jd

class SportsHomeTvPage extends StatefulWidget {
  @override
  _SportsHomeTvPageState createState() => _SportsHomeTvPageState();
}

class _SportsHomeTvPageState extends State<SportsHomeTvPage> {
  SportsHomeTVVm vm = Get.put(SportsHomeTVVm());
  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SportsHomeTVVm>(
        assignId: true,
        builder: (vm) {
          return CustomScrollView(
            slivers: [
              _buildSwiperWidget(),
              _buildTextAdWidget(vm),
              _buildGuessLikeWidget(vm),
              _recentlyUpdateTitleWidget(),
              _recentlyUpdateGridView(vm),
            ],
          );
        });
  }

  ///Swiper
  Widget _buildSwiperWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Swiper(
          itemCount: 5,
          autoplay: true,
          viewportFraction: 0.95,
          pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.red, color: Colors.green)),
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 0) {
              return Image.asset(
                AssetBundleUtils.getImgPath('bg_0', format: 'jpg'),
                fit: BoxFit.fill,
              );
            }
            return Image.asset(
              AssetBundleUtils.getImgPath('bg_1', format: 'jpg'),
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }

  ///文本广告
  Widget _buildTextAdWidget(SportsHomeTVVm vm) {
    return SliverToBoxAdapter(
      child: Container(
        height: 40,
        color: Colors.grey[100],
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        child: TimerWidget(
          maxIndex: 2,
          builder: (BuildContext context, int index) {
            return Text(
              vm.textAdList[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuessLikeWidget(SportsHomeTVVm vm) {
    return SliverToBoxAdapter(
      child: Container(
        height: 170,
        child: ListView.builder(
          itemCount: vm.likeList.length,
          itemExtent: 200,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Map video = vm.likeList[index];
            return SportsHomeTVItem(video);
          },
        ),
      ),
    );
  }

  Widget _recentlyUpdateTitleWidget() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Text(
          '最近更新',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  Widget _recentlyUpdateGridView(SportsHomeTVVm vm) {
    return SliverGrid(
      //Grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //Grid按两列显示
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Map video = vm.likeList[index];
          //创建子widget
          return SportsHomeTVItem(video);
        },
        childCount: 4,
      ),
    );
  }
}
