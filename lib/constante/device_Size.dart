// ignore_for_file: file_names

class Scrinetype {
  static bool isWeb = false;
  static bool isTablet = false;
  static bool isMobile = false;
  static double width = 0;
  static void setSize(double wd) {
    width = wd;
    if (wd > 1100) {
      isWeb = true;
      isTablet = false;
      isMobile = false;
    } else if (wd > 800) {
      isWeb = true;
      isTablet = false;
      isMobile = false;
    } else {
      isWeb = false;
      isTablet = false;
      isMobile = true;
    }
  }
}
