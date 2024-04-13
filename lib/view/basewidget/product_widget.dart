import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/favourite_button.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sixvalley_ecommerce/data/model/response/product_details_model.dart' as pd;
import '../screen/product/widget/cart_bottom_sheet.dart';

class ProductWidget extends StatefulWidget {
  final Product productModel;
  // final pd.ProductDetailsModel? product;
  const ProductWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  // bool vacationIsOn = false;
  // bool temporaryClose = false;
  //
  // @override
  // void initState() {
  //
  //   super.initState();
  //
  //   if(widget.product != null && widget.product!.seller != null && widget.product!.seller!.shop!.vacationEndDate != null){
  //     DateTime vacationDate = DateTime.parse(widget.product!.seller!.shop!.vacationEndDate!);
  //     DateTime vacationStartDate = DateTime.parse(widget.product!.seller!.shop!.vacationStartDate!);
  //     final today = DateTime.now();
  //     final difference = vacationDate.difference(today).inDays;
  //     final startDate = vacationStartDate.difference(today).inDays;
  //
  //     if(difference >= 0 && widget.product!.seller!.shop!.vacationStatus == 1 && startDate <= 0){
  //       vacationIsOn = true;
  //     }
  //
  //     else{
  //       vacationIsOn = false;
  //     }
  //   }
  //
  //   if(widget.product != null && widget.product!.seller != null && widget.product!.seller!.shop!.temporaryClose == 1){
  //     temporaryClose = true;
  //   }else{
  //     temporaryClose = false;
  //   }
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    String ratting = widget.productModel.rating != null && widget.productModel.rating!.isNotEmpty? widget.productModel.rating![0].average! : "0";

    return InkWell(
      onTap: () {Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (context, anim1, anim2) => ProductDetails(productId: widget.productModel.id,slug: widget.productModel.slug),
        ));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).highlightColor,
          boxShadow: Provider.of<ThemeProvider>(context, listen: false).darkTheme? null : [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),
        child:
        Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 152, decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(.05) : ColorResources.getIconBg(context),
                borderRadius: BorderRadius.circular(30),),
                    child: ClipRRect(borderRadius:  BorderRadius.circular(30),
                        child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${widget.productModel.thumbnail}',
                          height: MediaQuery.of(context).size.width/2.45,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,))),

            // Product Details
            Padding(padding: const EdgeInsets.only(top :Dimensions.paddingSizeSmall,bottom: 5, left: 5,right: 5),
              child: Center(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  if(widget.productModel.currentStock! < widget.productModel.minimumOrderQuantity! && widget.productModel.productType == 'physical')
                  Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                    child: Text(getTranslated('out_of_stock', context)??'', style: textRegular.copyWith(color: const Color(0xFFF36A6A)))),


                    Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          const Icon(Icons.star_rate_rounded, color: Colors.orange,size: 20),
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(double.parse(ratting).toStringAsFixed(1), style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),),



                          Text('(${widget.productModel.reviewCount.toString()})',
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),

                        ]), //Rating

                    Padding(padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(widget.productModel.name ?? '', textAlign: TextAlign.center,
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400), maxLines: 2,
                          overflow: TextOverflow.ellipsis)), //name of product






                      widget.productModel.discount!= null && widget.productModel.discount! > 0 ?
                      Text(PriceConverter.convertPrice(context, widget.productModel.unitPrice),
                      style: titleRegular.copyWith(color: Theme.of(context).hintColor,
                        decoration: TextDecoration.lineThrough,
                          fontSize: Dimensions.fontSizeSmall)) : const SizedBox.shrink(), //Before discount
                    const SizedBox(height: 2,),


                    Text(PriceConverter.convertPrice(context,
                        widget.productModel.unitPrice, discountType: widget.productModel.discountType,
                        discount: widget.productModel.discount),
                      style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),

                  InkWell(
                    onTap: () {

                        showModalBottomSheet(context: context, isScrollControlled: true,
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                            builder: (con) => CartBottomSheet(product:pd.ProductDetailsModel(), callback: (){
                              showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                            },));


                    },
                    child: Container(
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        getTranslated('add_to_cart', context)!,
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                            color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).highlightColor),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ]), //thumbnail

          // Off

              widget.productModel.discount! > 0 ?
              Positioned(top: 10, left: 10, child: Container(height: 20,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                borderRadius: BorderRadius.circular(20),),

              child: Center(
                child: Text(PriceConverter.percentageCalculation(context, widget.productModel.unitPrice,
                      widget.productModel.discount, widget.productModel.discountType),
                  style: textRegular.copyWith(color: Theme.of(context).highlightColor,
                      fontSize: Dimensions.fontSizeSmall)),
              ),
            ), //discount
                   ) : const SizedBox.shrink(),

              Positioned(top: 135, right: 5,
                child: FavouriteButton(
                  backgroundColor: ColorResources.getImageBg(context),
                  productId: widget.productModel.id,
            ),
          ),




        ]),
      ),
    );
  }
}
