
import 'package:get/get.dart';
import 'package:skin/core/constant/routes.dart';
import 'package:skin/view/screen/auth/create_center.dart';
import 'package:skin/view/screen/auth/login.dart';
import 'package:skin/view/screen/auth/signup.dart';
import 'package:skin/view/screen/clinic/clinic_details.dart';
import 'package:skin/view/screen/clinic/consultation_screen.dart';
import 'package:skin/view/screen/home.dart';
import 'package:skin/view/screen/home_doctor.dart';
import 'package:skin/view/screen/location/location.dart';
import 'package:skin/view/screen/splash/splash.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.splash, page:()=> Splash()),
  GetPage(name: AppRoute.login, page:()=> Login()),
  GetPage(name: AppRoute.signup, page:()=> SignUp()),
  GetPage(name: AppRoute.homeDoctor, page:()=> HomeDoctorPage()),
  GetPage(name: AppRoute.home, page:()=> HomePage()),
  GetPage(name: AppRoute.createCenter, page:()=> CreateCenter()),
  GetPage(name: AppRoute.clinicDetails, page:()=> ClinicDetailsPage()),
  GetPage(name: AppRoute.consultationPage, page:()=> ConsultationScreen()),
  GetPage(name: AppRoute.locationPage, page:()=>LocationPage()),
];
