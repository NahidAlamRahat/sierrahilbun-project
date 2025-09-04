import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_button/app_button.dart';
import '../../../widgets/app_image/app_image_circular.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/text_field_widget/text_field_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';


class ChangeProfileScreen extends StatelessWidget {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      resizeToAvoidBottomInset: false,

      appBar: AppbarWidget(
        backgroundColor: AppColors.appBackgroundColor,
       leading:  GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        showLeading: true,
        textWidget: TextWidget(text: "Change Profile Information",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          textAlignment: TextAlign.center,
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AppImageCircular(
                  fit: BoxFit.cover,
                  url:
                      "https://cdn.pixabay.com/photo/2016/12/07/21/01/cartoon-1890438_640.jpg",
                  width: AppSize.width(value: 148),
                  height: AppSize.width(value: 148),
                ),
                Positioned(
                  bottom: 2,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 24),
                      ),
                    ),
        
                  ),
                ),
              ],
            ),
        
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    TextWidget(text: 'Full Name',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                        borderRadius: 12,
                        controller: controller, hintText: "Enter Name"),

                    TextWidget(text: 'Phone Number',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                        borderRadius: 12,
                        controller: controller, hintText: "Enter Number"),

                    TextWidget(text: 'Email',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                        borderRadius: 12,
                        controller: controller, hintText: "Enter Email"),

                    TextWidget(text: 'Address',
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    TextFieldWidget(
                        borderRadius: 12,
                        controller: controller, hintText: "Enter Address"),


                  ],
                                ),
                ),),
            ),
          ],
        ),
      ),
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
    );
  }
}
