import 'package:iqchallenges/config/shared%20preferences/shared_preferences.dart';

class Stringconstants {
  static String username = 'username';
  static String interested = 'interested';
  static String currentlvl = 'currentlvl';
  static String backgrounds = 'backgroundSound';
  static String sounde = 'soundEffect';

  static String name = CacheHelper.getData(key: username) ?? '';
  static String interestedin = CacheHelper.getData(key: interested);
  static int currentlevel = CacheHelper.getData(key: currentlvl);
  static bool backgroundSound = CacheHelper.getData(key: backgrounds) ?? true;
  static bool soundEffect = CacheHelper.getData(key: sounde) ?? true;
}
