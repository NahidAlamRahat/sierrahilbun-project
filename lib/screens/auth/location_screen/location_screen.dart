import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/constants/app_colors.dart';
import 'package:sierrahilbun/widgets/appbar_widget/appbar_widget.dart';
import 'package:sierrahilbun/widgets/button_widget/button_widget.dart';
import '../../../constants/app_image_path.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../reset_password_screen/controller/reset_password_onTap_button_controller.dart';

class LocationScreen extends StatelessWidget {

  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppImagePath.locationImage),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
        
                  TextWidget(
                      text: 'Set Your Location',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
        
                  TextWidget(
                    text: 'To help us connect you with nearby service providers or customers, please allow access to your location.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
        
                  SizedBox(height: AppSize.height(value: 20)),
        
                  buildForm(),
        
                  SizedBox(height: AppSize.height(value: 40)),
        
              /*    CommonElevatedButton(
                    text: 'Continue',
                    width: double.infinity,
                    onPressed: () => Get.toNamed(AppRoutes.shopInformationScreen),
                    backgroundColor: AppColor.backgroundColor,
                    borderRadius: 100,
                  ),*/


        
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  /// Text Field
  Widget buildForm() {
    return Form(
      child: Column(
        children: [

          Container(
            width: double.infinity,
            height: 54,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFF2F9FF) /* Cart */,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: const Color(0xFF001C60) /* Stoke */,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 123,
                  top: 18,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 158,
                    children: [
                      Text(
                        'Allow Location Access',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF181818) /* Text-2 */,
                          fontSize: 12,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),



          SizedBox(height: AppSize.height(value: 20)),

      Container(
        width: double.infinity,
        height: 54,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFffffff) /* Cart */,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: const Color(0xFF001C60) /* Stoke */,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

               Icon(Icons.location_on, color: AppColors.commonButtonColor),

              TextWidget(
                text: 'Enter your location manually',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),


              const Icon(Icons.cancel, color: AppColors.commonButtonColor),
            ],
          ),
        ),
      ),

          SizedBox(height: 20,),
          ButtonWidget(
            backgroundColor: AppColors.commonButtonColor,
            label: 'Continue',
          )

      ],
      ),
    );
  }
}
