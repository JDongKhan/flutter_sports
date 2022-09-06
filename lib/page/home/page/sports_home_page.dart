import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/search_bar.dart';
import '../model/sports_content.dart';
import '../vm/sports_home_vm.dart';
import '../widget/sports_home_item.dart';

class SportsHomePage extends StatefulWidget {
  const SportsHomePage(this.title);

  final String title;

  @override
  _SportsHomePageState createState() => _SportsHomePageState();
}

class _SportsHomePageState extends State<SportsHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SportsHomeVm>(
      assignId: true,
      tag: widget.title,
      builder: (vm) {
        return Column(
          children: [
            _buildSearch(),
            Expanded(
              child: _buildContent(vm),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearch() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
              child: SearchBar(
            height: 40,
          )),
          IconButton(
              icon: const Icon(
                Icons.airplay,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildContent(SportsHomeVm vm) {
    return ListView.separated(
      itemBuilder: (c, idx) {
        if (idx > vm.data.length) {
          return Container();
        }
        SportsContent content = vm.data[idx];
        if (content.flag == '1') {
          return SportsHomeItem1(content: content);
        }
        if (content.flag == '2') {
          return SportsHomeItem2(content: content);
        }
        if (content.flag == '3') {
          return SportsHomeItem3(content: content);
        }
        if (content.flag == '4') {
          return SportsHomeItem4(content: content);
        }

        if (content.flag == '5') {
          return SportsHomeItem5(content: content);
        }

        return SportsHomeItem(content: content);
      },
      separatorBuilder: (c, idx) {
        return const Divider();
      },
      itemCount: vm.data.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
