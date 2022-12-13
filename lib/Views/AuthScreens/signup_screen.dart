import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/list_dart.dart';
import '../../widgets_common/appLogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfeild.dart';
import '../../widgets_common/our_button.dart';
import '../HomeScreen/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isCheck = false;
  var controller = Get.put(AuthController());

  //textcontrollers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight *0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  'Join the $appname'.text.fontFamily(bold).white.size(18).make(),
                  15.heightBox,
                  Obx(()=> Column(
                      children: [
                        customTextFeild(hint: nameHint,title: name,controller: nameController,isPass: false),
                        customTextFeild(hint: emailHint,title: email,controller: emailController,isPass: false),
                        customTextFeild(hint: passwordHint,title: password,controller: passwordController,isPass: true),
                        customTextFeild(hint: passwordHint,title: retypePassword,controller: passwordRetypeController,isPass: true),
                        5.heightBox,

                        Row(
                          children: [
                            Checkbox(
                                activeColor: redColor,
                                checkColor: whiteColor,
                                value: isCheck,
                                onChanged: (newValue){
                                    setState((){
                                      isCheck = newValue!;
                                    });
                                    },
                            ),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'I agree to the ',
                                        style: TextStyle(
                                          fontFamily: regular,
                                          color: fontGrey,

                                        )
                                      ),
                                      TextSpan(
                                          text: tremsAndCond,
                                          style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor,

                                          )
                                      ),
                                      TextSpan(
                                          text: ' & ',
                                          style: TextStyle(
                                            fontFamily: regular,
                                            color: fontGrey,

                                          )
                                      ),
                                      TextSpan(
                                          text: privacyPolicy,
                                          style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor,
                                          )
                                      )
                                    ]
                                  ),
                              ),
                            )
                          ],
                        ),
                        controller.isLoading.value?CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ):ourButton(color: isCheck == true?redColor:lightGrey,title:signup,textColor:whiteColor,onPress: () async {
                            if(isCheck != false){
                              controller.isLoading(true);
                              try{
                                 await controller.signupMethod(
                                   email: emailController.text,
                                   password: passwordController.text,
                                 ).then((value){
                                   return controller.storeUserData(
                                     email: emailController.text,
                                     password: passwordController.text,
                                     name: nameController.text,
                                   );
                                 }).then((value){
                                   VxToast.show(context, msg: loggedin);
                                   Get.offAll(()=> Home());
                                 });
                              }catch(e){
                                auth.signOut();
                                controller.isLoading(false);
                                VxToast.show(context, msg: e.toString());
                              }
                            }
                        }).
                        box.
                        width(context.screenWidth-50).make(),
                        10.heightBox,
                        RichText(
                            text: TextSpan(
                              children:[
                                TextSpan(
                                  text: alredyHaveAccount,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: fontGrey,
                                  )
                                ),
                                TextSpan(
                                    text: login,
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: redColor,
                                    )
                                ),
                              ]
                            )
                        ).onTap(() {
                          Get.back();
                        }),
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
