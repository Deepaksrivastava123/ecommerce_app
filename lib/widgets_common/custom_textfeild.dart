import 'package:ecommerce_app/consts/consts.dart';

Widget customTextFeild({String? title,String? hint,controller,isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        title!.text.color(Colors.red).fontFamily(semibold).size(16).make(),
        5.heightBox,
         TextFormField(
           controller: controller,
           obscureText: isPass,
           decoration: InputDecoration(
             hintStyle: TextStyle(
               fontFamily: semibold,
               color: fontGrey,
             ),
             hintText: hint,
             isDense: true,
             fillColor: lightGrey,
             filled: true,
             border: InputBorder.none,
             focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(
                 color: Colors.red,
               )
             )
           ),
         ),
      5.heightBox,
    ],
  );
}