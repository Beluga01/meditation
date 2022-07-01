import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? bannerAd;

  Future<void> initAdmob() {
    return MobileAds.instance.initialize();
  }

  void initBannerAd(){
    bannerAd = BannerAd(
      size: AdSize.banner, //サイズかえたいときはかえる
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(),
      request: AdRequest(),
    );
  }

  void loadBannerAd() {
    bannerAd?.load();
  }

  void dispose(){
    bannerAd?.dispose();
  }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8378981904009164~2499046304";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8378981904009164~8213858677";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111"; // OK
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716"; // OK
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712"; // OK
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910"; // OK
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


}
