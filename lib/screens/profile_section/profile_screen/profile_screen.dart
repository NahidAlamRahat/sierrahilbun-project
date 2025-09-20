import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/constants/app_icons_path.dart';
import 'package:sierrahilbun/screens/profile_section/profile_screen/controller/profile_controller.dart';
import 'package:sierrahilbun/screens/profile_section/profile_screen/widget/ProfileRow.dart';
import '../../../constants/app_image_path.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_button/app_button.dart';
import '../../../widgets/app_image/app_image_circular.dart';
import '../../../widgets/showCustomDialog.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    // Get the current theme data

    return Scaffold(
      backgroundColor: Color(0xFFF2F9FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F9FF),
        title: TextWidget(
          text: 'Profile',
          fontSize: AppSize.width(value: 18),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Row(
                children: [
                  AppImageCircular(
                    fit: BoxFit.cover,
                    url:
                        "https://cdn.pixabay.com/photo/2016/12/07/21/01/cartoon-1890438_640.jpg",
                    width: AppSize.width(value: 124),
                    height: AppSize.width(value: 124),
                  ),
                  // Gap(width: AppSize.width(value: 20)),
                  Column(
                    spacing: AppSize.size.height * 0.014,
                    children: [
                      TextWidget(
                        text: "Sabbir Ahmed",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidget(
                        text: "012345-678912",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w500,
                        // Use the text color from the current theme
                      ),

                      AppButton(
                        filColor: AppColors.commonButtonColor,
                        title: "Edit Profaile",
                        width: AppSize.size.width * 0.3,
                        height: AppSize.size.width * 0.1,
                        onTap: () => Get.toNamed(AppRoutes.changeProfileScreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: AppSize.size.height * 0.03,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileRow(
                      imagePath: AppIconsPath.lockIcon,
                      // Flutter built-in icon
                      onTap: () => Get.toNamed(AppRoutes.changePassScreen),
                      text: "Password",
                    ),

                    ProfileRow(
                      imagePath: AppIconsPath.deleteBoxIcon,
                      text: "Delete Account",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowCustomDialog(
                              title: 'Want to delete account !',
                              description:
                                  'Please confirm your password to remove your account.',
                              descriptionStyle: TextStyle(color: Colors.black),
                              actionsLayout: ActionsLayout.column,
                              image: Image.asset(
                                AppImagePath.deleteBox,
                                height: 24,
                                width: 24,
                              ),
                              actions: [
                                TextWidget(
                                  text: 'Password',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  textAlignment: TextAlign.start,
                                ),

                                // TextFieldWidget(
                                //   borderRadius: 12,
                                //   controller: controller,
                                //   hintText: 'password',
                                // ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.width(
                                              value: 18,
                                            ),
                                            vertical: AppSize.width(value: 14),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextWidget(
                                              text: "Cancel",

                                              fontSize: AppSize.width(
                                                value: 16,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              fontColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.signInScreen);
                                        },
                                        child: AppButton(
                                          filColor: AppColors.commonButtonColor,
                                          title: "Delete",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    ProfileRow(
                      imagePath: AppIconsPath.logoutIcon,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShowCustomDialog(
                              image: Image.asset(AppImagePath.logoutImage),
                              actionsLayout: ActionsLayout.row,
                              title: 'Do you want to log out of your profile?',
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.width(
                                              value: 18,
                                            ),
                                            vertical: AppSize.width(value: 14),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextWidget(
                                              text: "Cancel",
                                              fontSize: AppSize.width(
                                                value: 16,
                                              ),
                                              fontWeight: FontWeight.w500,
                                              fontColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 8),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          profileController.logout();
                                        },
                                        child: AppButton(
                                          filColor: AppColors.commonButtonColor,
                                          title: "Log Out",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      text: "Log Out",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
