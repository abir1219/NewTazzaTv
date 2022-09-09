import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';



class AddMobHelper {
  final bool _testMode = true;
  Future<InitializationStatus>? initialization;

  static String get bannerUnit => "ca-app-pub-5261140081598188~3898986402";

  AddMobHelper({required this.initialization});

  String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5261140081598188~3898986402";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  String get bannerAdUnitId {
    if (_testMode == true) {
      return "ca-app-pub-5261140081598188~3898986402";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-5261140081598188~3898986402";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  BannerAdListener get adListner => _adListner;

  final BannerAdListener _adListner = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad Loaded'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad Opened'),
    onAdClosed: (Ad ad) => print('Ad Closed'),
    onAdImpression: (Ad ad) => print('Ad Impression'),
  );

static BannerAd getBanner() {
    BannerAd bAd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerUnit,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: const AdRequest());

    return bAd;
  }

}
