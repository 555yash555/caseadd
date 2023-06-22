import 'package:flutter/material.dart';
import 'package:juridentt/addcase/cases.dart';
import 'package:juridentt/addcase/files.dart';
import 'package:juridentt/addcase/landing_page1.dart';
import 'package:juridentt/addcase/newcase_form.dart';
import 'package:juridentt/authentication/login/login.dart';
import 'package:juridentt/authentication/login/login_otp.dart';
import 'package:juridentt/authentication/phone/phone_number_input.dart';
import 'package:juridentt/authentication/signup/signup.dart';
import 'package:juridentt/authentication/signup/signup_otp.dart';
import 'package:juridentt/home.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case homescreen.routename:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AuthScreen(),
    //   );

    case '/login':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case '/signup':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );

    case '/loginotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('useremail') &&
          arguments.containsKey('userpassword')) {
        final useremail = arguments['useremail'] as String;
        final userpassword = arguments['userpassword'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => LoginOtp(
            useremail: useremail,
            userpassword: userpassword,
          ),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) =>
              const LoginScreen(), // Replace ErrorPage with your desired error page
        );
      }

    case '/signupotp':
      final arguments = routeSettings.arguments as Map<String, dynamic>?;

      if (arguments != null &&
          arguments.containsKey('email') &&
          arguments.containsKey('password') &&
          arguments.containsKey('confirmPassword') &&
          arguments.containsKey('username')) {
        final email = arguments['email'] as String;
        final password = arguments['password'] as String;
        final confirmPassword = arguments['confirmPassword'] as String;
        final username = arguments['username'] as String;

        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SignUpOtp(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            username: username,
          ),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) =>
              const SignupScreen(), // Replace ErrorPage with your desired error page
        );
      }

    case '/homescreen':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Homescreen(),
      );
    case '/addcase':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LandingPage1(),
      );
    case '/newcase':
      return MaterialPageRoute(
        settings: routeSettings,
        // builder: (_) => const newcase_form(),
        builder: (_) => newcase_form(),
      );
    case '/viewcase':
      return MaterialPageRoute(
        settings: routeSettings,
        // builder: (_) => const newcase_form(),
        builder: (_) => const CasePage(),
      );
    case '/filedownload':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Downloadfiles(),
      );
    case '/phonenumberinput':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PhoneNumberInput(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const SafeArea(
          child: Scaffold(
            body: Center(
              child: Text(
                'wrong page',
              ),
            ),
          ),
        ),
      );
  }
}
