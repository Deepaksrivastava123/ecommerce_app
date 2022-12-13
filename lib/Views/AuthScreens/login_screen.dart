import 'package:ecommerce_app/Views/AuthScreens/signup_screen.dart';
import 'package:ecommerce_app/Views/HomeScreen/home.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/list_dart.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/widgets_common/appLogo_widget.dart';
import 'package:ecommerce_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/custom_textfeild.dart';
import '../../widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var controller = Get.put(AuthController());

    return bgWidget(

      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight *0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              'Log in to $appname'.text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(()=>
                 Column(
                  children: [
                    customTextFeild(hint: emailHint,title: email,isPass: false,controller: controller.emailController),
                    customTextFeild(hint: passwordHint,title: password,isPass: true,controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){},
                          child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isLoading.value? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                    :ourButton(color: redColor,title:login,textColor:whiteColor,onPress: () async {
                      controller.isLoading(true);
                      await controller.loginMethod(context: context).then((value){
                        if(value!=null){
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(()=>Home());
                        }else{
                          controller.isLoading(false);
                        }
                      });

                    }).
                    box.
                    width(context.screenWidth-50).make(),

                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),

                    5.heightBox,
                    ourButton(color: lightGolden,title:signup,textColor:redColor,onPress: (){
                      Get.to(()=>SignUp());
                    }).
                    box.
                    width(context.screenWidth-50).make(),

                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),

                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:List.generate(3, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(socialIconList[index],
                           width:30 ,
                          ),
                        ),
                      )),
                    )
                  ],
                ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
              )
            ],
          ),
        )
      )
    );
  }
}
