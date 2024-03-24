import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../../../provider/splash_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../basewidget/select_currency_bottom_sheet.dart';
import '../../../basewidget/select_language_bottom_sheet.dart';

class CartWidgetHomePage extends StatelessWidget {
  const CartWidgetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Provider.of<SplashProvider>(context, listen: false).configModel!.currencyModel != 'single_currency' ? Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => showModalBottomSheet(backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context, builder: (_)=> const SelectCurrencyBottomSheet()),
            icon: Stack(clipBehavior: Clip.none, children: [

              Text("${Provider.of<SplashProvider>(context).myCurrency!.name}",
                style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold, color: ColorResources.getPrimary(context)),
              )

            ]),
          ),
        ):Container(),

        AppConstants.languages.length > 1 ? Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => showModalBottomSheet(backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context, builder: (_)=> const SelectLanguageBottomSheet()),

            icon: Stack(clipBehavior: Clip.none, children: [
              Icon(Icons.translate),


            ]),
          ),
        ):Container(),

        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, _) {
            return IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
              icon: Stack(clipBehavior: Clip.none, children: [
                Image.asset(Images.notification,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    color: ColorResources.getPrimary(context)),
                Positioned(top: -4, right: -4,
                  child: CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                    child: Text(notificationProvider.notificationModel?.newNotificationItem.toString() ?? '0',
                        style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  ),
                ),

              ]),
            );
          }
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: Stack(clipBehavior: Clip.none, children: [
              Image.asset(Images.cartArrowDownImage,
                  height: Dimensions.iconSizeDefault,
                  width: Dimensions.iconSizeDefault,
                  color: ColorResources.getPrimary(context)),
              Positioned(top: -4, right: -4,
                child: Consumer<CartProvider>(builder: (context, cart, child) {
                  return CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                    child: Text(cart.cartList.length.toString(),
                        style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  );
                }),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
