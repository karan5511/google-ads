
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob inline ads'),
      ),
      body: FutureBuilder<InitializationStatus>(
          future: _initGoogleMobileAds(),
          builder: (context, snapshot) {
            List<Widget> children = [];

            if (snapshot.connectionState == ConnectionState.waiting) {
              children.add(Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 48.0,
                  height: 48.0,
                ),
              ));
            } else {
              if (snapshot.hasData) {
                children.addAll([
                  ElevatedButton(
                    child: Text('Banner inline ad'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/banner');
                    },
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    child: Text('Native inline ad'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/native');
                    },
                  ),
                ]);
              } else if (snapshot.hasError) {
                children.add(Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 8.0),
                      Text('Failed to initialize AdMob SDK'),
                    ],
                  ),
                ));
              }
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            );
          }),
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
}
