import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/text_styles.dart';

extension StringExtension on String {
  // Capitalize the first letter of a string
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

extension NavigationExtensions on BuildContext {
  void navigate(PageRouteInfo route) {
    AutoRouter.of(this).push(route);
  }

  void popBack() {
    AutoRouter.of(this).popForced();
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String title, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: headingStyle.copyWith(
          fontSize: 16.sp,
        ),
      ),
      backgroundColor: greenColor,
      duration: Duration(seconds: 2),
    ),
  );
}

// extension ResponseHandler on Response {
//   void handleResponse({
//     required BuildContext context,
//     required VoidCallback onSuccess,
//   }) {
//     if (statusCode == 200) {
//       onSuccess();
//     } else if (statusCode == 500) {
//       showToast(data['message'], redColor);
//     } else if (statusCode == 401) {
//       getIt<AppPrefs>().token.clear();
//       AutoRouter.of(context).pushAndPopUntil(
//         LoginRoute(),
//         predicate: (route) => false,
//       );
//     }
//   }
// }
