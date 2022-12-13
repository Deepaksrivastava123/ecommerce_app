import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? userCredential;

    try{
       userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //sign up

  Future<UserCredential?> signupMethod({email,password,context}) async{
    UserCredential? userCredential;

    try{
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
 storeUserData({name,password,email}) async{
    DocumentReference store = await firestore.collection(userCollections).doc(currentUser!.uid);
    store.set({
      'name':name,
      'password':password,
      'email':email,
      'id':currentUser!.uid,
      'imageUrl':'',
      'cart_count':'00',
      'whishlist_count':'00',
      'order_count':'00',

    });
 }

 //signout method
 signoutMethod(context)async{
    try{
       await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
 }

}