import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../routes/app_routes.dart';
import '../../widgets/appbar_widget/appbar_widget.dart';
import '../../widgets/text_widget/text_widgets.dart';
import 'controller/terms_and_conditions_controller.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // final TermsAndConditionsController controller =
    //     Get.put(TermsAndConditionsController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppbarWidget(
        text: AppStrings.termsCondition,
        centerTitle: true,
      ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (controller.termsConditions.value.data == null) {
//           return const Center(child: Text('No terms and conditions available'));
//         }
//         final termsContent =
//             controller.termsConditions.value.data!.content ?? '';
      body:    SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // child: HtmlWidget(
          //   termsContent,
          // ),
    child: Text('data'),

)
//       }),
    );
  }


}



class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isMobile = screenWidth < 400;

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 500 : double.infinity,
        ),
        margin: isTablet ? EdgeInsets.symmetric(horizontal: (screenWidth - 500) / 2) : EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.termsAndConditionScreen,arguments: 'Terms & Conditions'),
                child: TextWidget(
                  text: 'Terms & Conditions',
                  fontSize: isTablet ? 14 : (isMobile ? 10 : 12),
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  underline: true,
                ),
              ),

              SizedBox(width: isMobile ? 6 : 8),

              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.termsAndConditionScreen, arguments:'Privacy Policy'),

                child: TextWidget(
                  text: 'Privacy Policy',
                  fontSize: isTablet ? 14 : (isMobile ? 10 : 12),
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  underline: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }










}
