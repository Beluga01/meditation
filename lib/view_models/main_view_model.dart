import 'package:flutter/material.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';

class MainViewModel extends ChangeNotifier {
  final SharedPrefsRepository sharedPrefsRepository;
  final SoundManager soundManager;
  final AdManager adManager;
  final InAppPurchaseManager inAppPurchaseManager;

  MainViewModel(
      {required this.sharedPrefsRepository,
      required this.soundManager,
      required this.adManager,
      required this.inAppPurchaseManager});

  Future<void> skipIntro() async{
    await sharedPrefsRepository.skipIntro();
  }
}
