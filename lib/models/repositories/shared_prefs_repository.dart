import 'package:flutter/material.dart';
import 'package:meditation/data_models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_IS_SKIP_INTRO = "is_skip_intro";
const PREF_KEY_LEVEL_ID = "level_id";
const PREF_KEY_THEME_ID = "theme_id";
const PREF_KEY_TIME = "time";

class SharedPrefsRepository {
  Future<bool> skipIntro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PREF_KEY_IS_SKIP_INTRO, true);
  }

  Future<bool> isSkipIntroScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false;
  }

  Future<UserSettings> getUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return UserSettings(
      levelId: prefs.getInt(PREF_KEY_LEVEL_ID) ?? 0,
      themeId: prefs.getInt(PREF_KEY_THEME_ID) ?? 0,
      timeMinutes: prefs.getInt(PREF_KEY_TIME) ?? 5,
      isSkipIntroScreen: prefs.getBool(PREF_KEY_IS_SKIP_INTRO) ?? false,
    );
  }

  Future<void> setLevel(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_KEY_LEVEL_ID, index);
  }

  Future<void> setTime(int timeMinutes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_KEY_TIME, timeMinutes);
  }

  Future<void> setTheme(int index) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_KEY_THEME_ID, index);
  }
}
