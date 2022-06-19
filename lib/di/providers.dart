import 'package:flutter/material.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<SharedPrefsRepository>(create: (_) => SharedPrefsRepository()),
  Provider<SoundManager>(create: (_) => SoundManager()),
  Provider<AdManager>(create: (_) => AdManager()),
  Provider<InAppPurchaseManager>(create: (_) => InAppPurchaseManager()),
];

List<SingleChildWidget> dependentModels = [];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<MainViewModel>(
    create: (context) => MainViewModel(
      sharedPrefsRepository: context.read<SharedPrefsRepository>(),
      soundManager: context.read<SoundManager>(),
      adManager: context.read<AdManager>(),
      inAppPurchaseManager: context.read<InAppPurchaseManager>(),
    ),
  ),
];
