import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sierrahilbun/routes/route_manager.dart';
import 'package:sierrahilbun/utils/app_size.dart';

import 'constants/app_colors.dart';
import 'constants/app_strings.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppSize.size =
          MediaQuery.of(context).size;
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green500),
          useMaterial3: true,
          fontFamily: AppStrings.fontFamilyName,
        ),
        initialRoute: RouteManager.initial,
        getPages: RouteManager.getPages(),
      );
    });
  }
}
