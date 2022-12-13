
import 'package:ecommerce_app/Views/CategoryScreen/category_screen.dart';
import 'package:ecommerce_app/Views/CartScreen/cart_screen.dart';
import 'package:ecommerce_app/Views/HomeScreen/home_screen.dart';
import 'package:ecommerce_app/Views/ProfileScreen/profile_screen.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navBarItems = [
     BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
     BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label: categories),
     BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
     BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account)
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: ()async{

        showDialog(barrierDismissible:false,context: context, builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
           Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(items: navBarItems,
           currentIndex: controller.currentNavIndex.value,
           selectedItemColor: redColor,
           selectedLabelStyle: TextStyle(fontFamily: semibold),
           type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
             onTap: (value){
               controller.currentNavIndex.value = value;
             },
          ),
        ),
      ),
    );
  }
}

