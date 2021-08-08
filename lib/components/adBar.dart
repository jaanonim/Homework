import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:flutter/material.dart';

class AdBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(elevation: 0,
      child: UnityBannerAd(
        placementId: "Banner_Android",
        listener: (state, args) {
          print('Banner Listener: $state => $args');
        },
      ),);
  }
}
