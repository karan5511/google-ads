
import 'package:admob_inline_ads_in_flutter/ad_helper.dart';

import 'package:admob_inline_ads_in_flutter/destination.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';

class NativeInlinePage extends StatefulWidget {
  final List<Destination> entries;

  NativeInlinePage({
    required this.entries,
  });

  @override
  State createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  static final _kAdIndex = 4;

  late NativeAd _ad;

  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: AdManager.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Native Inline Ad'),
      ),
      body: ListView.builder(
        itemCount: widget.entries.length + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isAdLoaded && index == _kAdIndex) {
            return Container(
              child: AdWidget(ad: _ad),
              height: 72.0,
              alignment: Alignment.center,
            );
          } else {
            final item = widget.entries[_getDestinationItemIndex(index)];

            return ListTile(
              leading: Image.asset(
                item.asset,
                width: 48,
                height: 48,
                package: 'flutter_gallery_assets',
                fit: BoxFit.cover,
              ),
              title: Text(item.name),
              subtitle: Text(item.duration),
              onTap: () {
                print('Clicked ${item.name}');
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}
