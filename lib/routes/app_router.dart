import 'package:flutter/material.dart';

// AUTH
import 'package:demo/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:demo/features/auth/presentation/pages/onboarding/on_boarding_screen.dart';
import 'package:demo/features/auth/presentation/pages/auth/sign_in_screen.dart';
import 'package:demo/features/auth/presentation/pages/auth/sign_up_screen.dart';
import 'package:demo/features/auth/presentation/pages/auth/forgot_password_screen.dart';
import 'package:demo/features/auth/presentation/pages/auth/check_email_screen.dart';

// FEATURES
import 'package:demo/features/explore/presentation/pages/explore_screen.dart';
import 'package:demo/features/guide/presentation/pages/guide_page_screen.dart';
import 'package:demo/features/my_trip/presentation/pages/my_trips_screen.dart';
import 'package:demo/features/tour/presentation/pages/tour_detail_screen.dart';
import 'package:demo/features/notification/presentation/pages/notifications_screen.dart';
import 'package:demo/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:demo/features/profile/presentation/pages/profile_screen.dart';
import 'package:demo/features/blog/presentation/pages/blog_detail_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot_password';
  static const String checkEmail = '/check_email';

  static const String explore = '/explore';
  static const String guide = '/guide_page';
  static const String myTrip = '/my_trip';
  static const String tourDetail = '/tour_detail';
  static const String notification = '/notification';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String blog ='/blog';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    signin: (context) => const SignInScreen(),
    signup: (context) => const SignUpScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    checkEmail: (context) => const CheckEmailScreen(),

    explore: (context) => const ExploreScreen(),
    guide: (context) => const GuidePageScreen(),
    myTrip: (context) => const MyTripsScreen(),
    tourDetail: (context) => TourDetailScreen(),
    notification: (context) => NotificationsScreen(),
    chat: (context) => ChatListScreen(),
    profile: (context) => ProfileScreen(),
    blog: (context) => BlogDetailScreen(),
  };
}