import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_button/app_button.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class ChangePassScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(value: 16),
            vertical: AppSize.width(value: 20),
          ),
          child: AppButton(
            filColor: AppColors.commonButtonColor,
            title: "Save",
            titleSize: AppSize.width(value: 18),
            borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
          ),
        ),
      ),
      // appBar: CustomAppbar(
      //   text: "Change Password",
      //   appThemeColor: appThemeColor,
      // ),
      appBar: AppbarWidget(
        backgroundColor: AppColors.appBackgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        text: "Change Password",
        textWidget: TextWidget(
          text: "Change Password",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          textAlignment: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppImage(
              width: AppSize.size.width * 0.6,
              path: AppImagePath.changePassImg,
            ),

            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .1), // Shadow color
                      offset: Offset(
                        0,
                        2,
                      ), // Vertical offset, giving shadow on bottom
                      blurRadius: 8, // Blur radius
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .1), // Shadow color
                      offset: Offset(
                        0,
                        -2,
                      ), // Vertical offset, giving shadow on top
                      blurRadius: 8, // Blur radius
                    ),
                  ],
                  borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(AppSize.width(value: 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    TextWidget(
                      text: 'Old Password',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                      borderRadius: 12,
                      controller: controller,
                      hintText: "Old Password",
                    ),

                    TextWidget(
                      text: 'New Password',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                      borderRadius: 12,
                      controller: controller,
                      hintText: "New Password",
                    ),

                    TextWidget(
                      text: 'Confirm Password',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),

                    TextFieldWidget(
                      borderRadius: 12,
                      controller: controller,
                      hintText: "Enter Confirm Password",
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
