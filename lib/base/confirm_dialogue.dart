
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:shopping_app/data/repos/order_controller.dart';
import 'package:shopping_app/uitls/app_dimensions.dart';
import 'package:shopping_app/uitls/styles.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;

  ConfirmationDialog({
    required this.icon,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Image.asset(icon, width: 50, height: 50),
                ),
                if (title != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.red),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Text(
                    description,
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                GetBuilder<OrderController>(builder: (orderController) {
                  return !orderController.isLoading
                      ? Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => isLogOut
                              ? onYesPressed()
                              : onNoPressed != null
                              ? onNoPressed!()
                              : Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.3),
                            minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL)),
                          ),
                          child: Text(
                            isLogOut ? 'yes' : 'no',
                            textAlign: TextAlign.center,
                            style: robotoBold.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .color),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                      Expanded(
                        child: CustomButton(
                          buttonText: isLogOut ? 'no' : 'yes',
                          onPressed: () => isLogOut
                              ? Get.back()
                              : onYesPressed(),
                          radius: Dimensions.RADIUS_SMALL,
                          height: 40,
                        ),
                      ),
                    ],
                  )
                      : Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

