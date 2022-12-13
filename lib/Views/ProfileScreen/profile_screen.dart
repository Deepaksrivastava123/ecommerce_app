import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Views/AuthScreens/login_screen.dart';
import 'package:ecommerce_app/Views/ProfileScreen/edit_profile.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/list_dart.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'components/details_cart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return bgWidget(
      Scaffold(
        body:StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),),);
            }
            else{

              var data = snapshot.data!.docs[0];
              print(data);

              return SafeArea(
                  child: Column(
                    children: [

                      //edit profile button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(alignment:Alignment.topRight,child: Icon(Icons.edit,color: whiteColor,) ,).onTap(() {

                          controller.nameController.text = data['name'];
                          Get.to(()=>EditProfileScreen(data: data,));
                        }),
                      ),

                      //users details section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children:[
                              data['imageUrl'] == ''?
                              Image.asset(imgProfile2,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                              :
                              Image.network(data['imageUrl'],width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                              10.widthBox,
                              Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      '${data['name']}'.text.fontFamily(semibold).white.make(),
                                      '${data['email']}'.text.white.make(),
                                    ],
                                  )
                              ),
                              OutlinedButton(onPressed: () async {
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(()=>LoginScreen());
                              },
                                child: logout.text.fontFamily(semibold).white.make(),
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: whiteColor,
                                    )
                                ),
                              )
                            ]
                        ),
                      ),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(count: data['cart_count'],title: 'in your cart',width: context.screenWidth/3.4),
                          detailsCard(count: data['whishlist_count'],title: 'in your wishlist',width: context.screenWidth/3.4),
                          detailsCard(count: data['order_count'],title: 'your orders',width: context.screenWidth/3.4),
                        ],
                      ),

                      //buttons section
                      ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount:profileButtonList.length ,
                          itemBuilder:(context,index){
                            return ListTile(
                              leading: Image.asset(profileButtonIcons[index],width: 22,),
                              title: '${profileButtonList[index]}'.text.fontFamily(semibold).color(darkFontGrey).make(),
                            );
                          }
                      ).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make()
                    ],
                  )
              );
            }
          },

       ),
      ),
    );
  }
}
