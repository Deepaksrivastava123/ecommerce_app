import 'package:ecommerce_app/consts/consts.dart';

Widget FeaturedButton({String ? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.width(216).margin(EdgeInsets.symmetric(horizontal: 5)).white.padding(EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
}