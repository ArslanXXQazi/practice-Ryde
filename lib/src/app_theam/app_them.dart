import 'package:practice_ryde/src/controllers/constants/linker.dart';

ThemeData lightMode=ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Appcolor.yellow,
    secondary: Colors.black,
    tertiary: Appcolor.grey,
    background: Colors.white,
  )
);

ThemeData darkMode=ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Appcolor.yellow,
      secondary: Colors.white,
      tertiary: Appcolor.grey,
      background: Color(0xff272B2F),
    )
);