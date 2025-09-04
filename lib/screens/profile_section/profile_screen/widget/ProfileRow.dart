import 'package:flutter/material.dart';

import '../../../../utils/app_size.dart';
import '../../../../widgets/text_widget/text_widgets.dart';

class ProfileRow extends StatelessWidget {
  final IconData? iconData; // যদি icon দাও
  final String? imagePath; // যদি image দাও
  final String? text;
  final VoidCallback? onTap;

  const ProfileRow({
    super.key,
    this.iconData,
    this.imagePath,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // এখানে condition: যদি imagePath থাকে তাহলে Image, নাহলে Icon
          if (imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6), // চাইলে rounded করতে পারো
              child: Image.asset(
                imagePath!,
                width: AppSize.width(value: 24),
                height: AppSize.width(value: 24),
                fit: BoxFit.cover,
              ),
            )
          else if (iconData != null)
            Icon(iconData, size: AppSize.width(value: 24)),

          SizedBox(width: AppSize.width(value: 10)),

          TextWidget(
            text: text ?? "",
            fontWeight: FontWeight.w500,
            fontSize: AppSize.width(value: 14),
          ),

          Spacer(),

          Icon(Icons.arrow_forward_ios, size: AppSize.width(value: 16)),
        ],
      ),
    );
  }
}
