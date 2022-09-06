import 'package:flutter/material.dart';

import '../utils/share_utils.dart';

///@Description TODO
///@Author jd
///分享按钮
IconButton shareButtonIcon(BuildContext context,
        {Color color = Colors.white}) =>
    IconButton(
      icon: Icon(Icons.share, color: color),
      onPressed: () {
        showShareBottomSheet(context);
      },
      tooltip: '分享',
    );
