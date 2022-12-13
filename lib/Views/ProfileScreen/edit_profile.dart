import 'dart:io';

import 'package:ecommerce_app/widgets_common/bg_widget.dart';
import 'package:ecommerce_app/widgets_common/custom_textfeild.dart';
import 'package:ecommerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {

  final dynamic data;
  EditProfileScreen({Key? key,this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {

     var controller = Get.find<ProfileController>();


     return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(()=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [

             //if data image url and controller path is empty
              data['imageUrl'] == '' &&controller.profileImagePath.isEmpty ? Image.asset(imgProfile2,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                  :
              //if data is not empty and controller path is empty
               data['imageUrl']!='' && controller.profileImagePath.isEmpty?
               Image.network(data['imageUrl'],
                 width: 100,
                 fit: BoxFit.cover,
               ).box.roundedFull.clip(Clip.antiAlias).make()

               //if both are empty
                  :
              Image.file(File(controller.profileImagePath.value),
              width: 100,
              fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              ourButton(color: redColor,onPress: (){
                 controller.changeImage(context);
              },textColor: whiteColor,title: 'Change'),
              Divider(),
              20.heightBox,
              customTextFeild(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass:false
              ),
              10.heightBox,
              customTextFeild(
                  controller: controller.oldPassController,
                  hint: passwordHint,
                  title: oldPass,
                  isPass:true
              ),
              10.heightBox,
              customTextFeild(
                  controller: controller.newPassController,
                  hint: passwordHint,
                  title: newPass  ,
                  isPass:true
              ),
              20.heightBox,
              controller.isLoading.value ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              )
              : SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(color: redColor,onPress: () async {
                    controller.isLoading(true);
                    //if image is not selected
                    if(controller.profileImagePath.value.isNotEmpty){
                      await controller.uploadProfileImage();
                    }else{
                      controller.profileImageLink = data['imageUrl'];
                    }

                    //if old password matches with database
                    if(data['password'] == controller.oldPassController.text){
                      await controller.changeAuthPassword(
                        email: data['email'],
                        password: controller.oldPassController.text,
                        newPassword: controller.newPassController.text
                      );
                      await controller.updateProfile(
                        imgUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.newPassController.text,
                      );
                      VxToast.show(context, msg: 'Updated');
                    }else{
                      VxToast.show(context, msg: 'Wrong Old password');
                      controller.isLoading(false);
                    }
                    },textColor: whiteColor,title: 'Save')),
            ],
          ).box.white.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 12,right: 12)).rounded.make(),
        ),
      ),
    );
  }
}
