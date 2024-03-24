import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_button.dart';
import 'package:provider/provider.dart';

import '../../provider/banner_provider.dart';
import '../screen/home/widget/footer_banner.dart';

class PopupBannerDialog extends StatelessWidget {
  final bool isFailed;
  final double rotateAngle;

  final String? title;
  final String? description;
  const PopupBannerDialog(
      {Key? key,
      this.isFailed = false,
      this.rotateAngle = 0,
      this.title,
      this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 1),
    //     child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
    //
    //         children: [
    //       SizedBox(
    //           height: 50,
    //           width: 35,
    //           child: CustomButton(
    //               radius: 100,
    //               buttonText: "X",
    //               onTap: () => Navigator.pop(context),
    //               backgroundColor: Theme.of(context).shadowColor)),
    //       SizedBox(height:.5),
    //       Consumer<BannerProvider>(
    //           builder: (context, footerBannerProvider, child) {
    //         return footerBannerProvider.popupBanner != null &&
    //                 footerBannerProvider.popupBanner!.isNotEmpty
    //             ? Padding(
    //                 padding:
    //                     const EdgeInsets.only(bottom: 2, left: 2, right: 2),
    //                 child: SingleBannersView(
    //                   bannerModel: footerBannerProvider.popupBanner?[0],
    //                   height: 400,
    //                 ))
    //             : const SizedBox();
    //       }),
    //     ]),
    //   ),
    // );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),

        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),

              ),
              width: 300,
              height: 402,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  Center(
                    child: Consumer<BannerProvider>(
                        builder: (context, footerBannerProvider, child) {
                      return footerBannerProvider.popupBanner != null &&
                              footerBannerProvider.popupBanner!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 2, left: 2, right: 2),
                              child: SingleBannersView(
                                bannerModel:
                                    footerBannerProvider.popupBanner?[0],
                                height: 400,
                              ))
                          : const SizedBox();
                    }), //
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(1.1, -0.63),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                    ),
                  ], shape: BoxShape.circle, color: Colors.white70),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
