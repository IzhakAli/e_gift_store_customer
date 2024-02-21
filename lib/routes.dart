import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:store/view/address/add.dart';
import 'package:store/view/address/adddetails.dart';
import 'package:store/view/address/view.dart';
import 'package:store/view/screen/about_us.dart';
import 'package:store/view/screen/ai/landing_screen.dart';
import 'package:store/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:store/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:store/view/screen/auth/forgetpassword/success_reset_password.dart';
import 'package:store/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:store/view/screen/auth/signup.dart';
import 'package:store/view/screen/auth/signupverifycode.dart';
import 'package:store/view/screen/auth/success_signup.dart';
import 'package:store/view/screen/cart.dart';
import 'package:store/view/screen/checkout.dart';
import 'package:store/view/screen/homescreen.dart';
import 'package:store/view/screen/items.dart';
import 'package:store/view/screen/language.dart';
import 'package:store/view/screen/myfavorite.dart';
import 'package:store/view/screen/onboarding.dart';
import 'package:store/view/screen/orders/archive.dart';
import 'package:store/view/screen/orders/details.dart';
import 'package:store/view/screen/orders/pending.dart';
import 'package:store/view/screen/orders/tracking.dart';
import 'package:store/view/screen/productdetails.dart';

import 'core/constant/routes.dart';
import 'core/middleware/mymiddleware.dart';
import 'view/screen/auth/login.dart';

List<GetPage<dynamic>>? routes = [
  // Auth
  GetPage(
      name: "/", page: () => const MyLanguage(), middlewares: [MyMiddleWare()]),
  // GetPage(name: "/", page: () => const Cart()),

  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verifyCode, page: () => const VerifyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetPassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(
      name: AppRoute.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),
  // OnBoarding
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  //HomePage
  GetPage(name: AppRoute.homePage, page: () => const HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Items()),
  GetPage(name: AppRoute.productDetails, page: () => const ProductDetails()),
  GetPage(name: AppRoute.myFavorite, page: () => const MyFavorite()),
  GetPage(name: AppRoute.cart, page: () => const Cart()),
  //Address
  GetPage(name: AppRoute.addressview, page: () => const AddressView()),
  GetPage(name: AppRoute.addressadd, page: () => const AddressAdd()),
  GetPage(
      name: AppRoute.addressadddetails, page: () => const AddressAddDetails()),

  //Checkout
  GetPage(name: AppRoute.checkout, page: () => const Checkout()),

  //Orders
  GetPage(name: AppRoute.orderspending, page: () => const OrdersPending()),
  GetPage(name: AppRoute.ordersarchive, page: () => const OrdersArchiveView()),
  GetPage(name: AppRoute.ordersdetails, page: () => const OrdersDetails()),
  GetPage(
      name: AppRoute.addressadddetails, page: () => const AddressAddDetails()),
  GetPage(name: AppRoute.tracking, page: () => const OrdersTracking()),

  //Offers
  // GetPage(name: AppRoute.offers, page: () => const OffersView())

  //AI
  GetPage(name: AppRoute.ai_landingscreen, page: () => const LandingScreen()),
  //About Us
  GetPage(name: AppRoute.aboutus, page: () => const AboutUs()),
];
