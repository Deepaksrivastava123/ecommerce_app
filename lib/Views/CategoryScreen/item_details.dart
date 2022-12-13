

import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/list_dart.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/widgets_common/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ItemDetails extends StatelessWidget {
  String ? title;
  final dynamic data;

  ItemDetails({Key? key,this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            controller.resetValues();
            Get.back();
          },icon: Icon(Icons.arrow_back),),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share),),
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline),),
          ],
        ),
        body: Column(

          children: [
            Expanded(
                child: Padding(padding: EdgeInsets.all(8),
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       //swiper section
                       VxSwiper.builder(
                           autoPlay: true,
                           height: 350,
                           itemCount: data['p_imgs'].length,
                           viewportFraction: 1.0,
                           aspectRatio: 16/9,
                           itemBuilder: (context,index){
                             return Image.network(data['p_imgs'][index],width: double.infinity,fit: BoxFit.cover,);
                           }
                       ),

                       10.heightBox,
                       title!.text.size(18).color(darkFontGrey).fontFamily(semibold).make(),
                       10.heightBox,
                       VxRating(
                         isSelectable:false,
                         value: double.parse(data['p_rating']),
                         onRatingUpdate: (value){},
                         normalColor: textfieldGrey,
                         selectionColor: golden,
                         size: 25,
                         maxRating: 5,
                         count: 5,
                       ),

                       10.heightBox,
                       '${data['p_price']}'.numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),

                       10.heightBox,
                       Row(
                         children: [
                           Expanded(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment:CrossAxisAlignment.start,
                                 children: [
                                   'Seller'.text.white.fontFamily(bold).make(),
                                   5.heightBox,
                                   '${data['p_seller']}'.text.white.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                                 ],
                               )
                           ),
                           CircleAvatar(
                             backgroundColor: Colors.white,
                             child: Icon(Icons.message_rounded,color: darkFontGrey,),
                           ),
                         ],
                       ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                       //colors section
                       20.heightBox,
                       Obx(()=> Column(
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width: 100,
                                   child: 'Color: '.text.color(textfieldGrey).make(),
                                 ),
                                 Row(
                                   children:List.generate(data['p_colors'].length, (index) => Stack(
                                     alignment: Alignment.center,
                                     children: [
                                       VxBox().size(40,40).roundedFull.color(Color(int.parse(data['p_colors'][index]))).margin(EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                                         controller.changeColorIndex(index);
                                       }),
                                       Visibility(
                                           visible: index == controller.colorIndex.value,
                                           child: Icon(Icons.done,color: Colors.white,))
                                     ],
                                   ),
                                   ),
                                 ),

                               ],


                             ).box.white.shadowSm.padding(EdgeInsets.all(8)).make(),

                             //quantiti section

                             Row(
                                 children: [
                                   SizedBox(
                                     width: 100,
                                     child: 'Quantity: '.text.color(textfieldGrey).make(),
                                   ),
                                   Obx(()=>
                                      Row(
                                         children:[
                                           IconButton(onPressed: (){
                                             controller.decreaseQuantity();
                                             controller.calculateTotalPrice(int.parse(data['p_price']));
                                           },
                                             icon: Icon(Icons.remove),
                                           ),
                                           controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                           IconButton(onPressed: (){
                                             controller.increaseQuantity(int.parse(data['p_quantity']));
                                             controller.calculateTotalPrice(int.parse(data['p_price']));
                                             },
                                             icon: Icon(Icons.add),
                                           ),
                                           10.widthBox,
                                           '(${data['p_quantity']} available)'.text.color(textfieldGrey).make(),
                                         ],
                                     ),
                                   ),
                                 ],
                         ).box.white.padding(EdgeInsets.all(8)).shadowSm.make(),

                             //total Row
                             Row(
                               children: [
                                 SizedBox(
                                   width: 100,
                                   child: 'Total: '.text.color(textfieldGrey).make(),
                                 ),
                                 '${controller.totalPrice.value}'.numCurrency.text.color(redColor).size(16).fontFamily(bold).make()
                               ],
                             ).box.white.padding(EdgeInsets.all(8)).shadowSm.make(),

                             //description section
                             10.heightBox,
                             Align(alignment:Alignment.centerLeft,child: 'Description'.text.color(darkFontGrey).fontFamily(semibold).make()),
                             10.heightBox,
                             Align(alignment:Alignment.centerLeft,child:'${data['p_desc']}'.text.color(darkFontGrey).make() ,),

                             //button section
                             10.heightBox,
                             ListView(
                               physics: NeverScrollableScrollPhysics(),
                               shrinkWrap: true,
                               children: List.generate(itemDetailsButtonList.length, (index) => ListTile(
                                 title: '${itemDetailsButtonList[index]}'.text.fontFamily(semibold).color(darkFontGrey).make(),
                                 trailing: Icon(Icons.arrow_forward),
                               )),
                             ),

                             //products you may like
                             Align(alignment:Alignment.centerLeft,child: productYouMayLike.text.fontFamily(bold).size(16).color(darkFontGrey).make()),

                             10.heightBox,
                             SingleChildScrollView(
                               scrollDirection: Axis.horizontal,
                               child:Row(
                                 children: List.generate(6, (index) => Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Image.asset(
                                       imgP1,
                                       width: 150,
                                       fit: BoxFit.cover,
                                     ),
                                     10.heightBox,
                                     'Laptop 4GB/64GB'.text.fontFamily(semibold).color(darkFontGrey).make(),
                                     10.heightBox,
                                     '\$500'.text.color(redColor).fontFamily(bold).size(16).make(),
                                   ],
                                 ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make()),
                               ) ,
                             )
                           ],
                   ),
                       )
]
                 )

              )

            )),
                 SizedBox(
                   width: double.infinity,
                   height: 60,
                   child: ourButton(
                     color: redColor,
                     onPress: (){
                       controller.addToCart(
                         color:data['p_colors'][controller.colorIndex.value].toString(),
                         context: context,
                         img: data['p_imgs'][0],
                         qty: controller.quantity.value,
                         sellername: data['p_seller'],
                         title: data['p_name'],
                         tprice: controller.totalPrice.value,
                       );
                       VxToast.show(context, msg: 'Added to cart');
                     },
                     textColor: whiteColor,
                     title: 'Add to cart',
                   ),
                 )
          ],
        ),
      ),
    );
  }
}
