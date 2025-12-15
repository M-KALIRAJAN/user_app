import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/views/screens/point_details.dart';
import 'package:mannai_user_app/views/screens/service_request_details.dart';
import 'package:mannai_user_app/widgets/dialogs/AccountCreated.dart';
import 'package:mannai_user_app/views/auth/AccountStepper.dart';
import 'package:mannai_user_app/views/auth/account_details.dart';
import 'package:mannai_user_app/views/auth/account_verification.dart';

import 'package:mannai_user_app/views/auth/login_view.dart';
import 'package:mannai_user_app/views/auth/otp.dart';
import 'package:mannai_user_app/views/auth/termsandconditions.dart';
import 'package:mannai_user_app/views/auth/upload_id_view.dart';
import 'package:mannai_user_app/views/bottomnav.dart';
import 'package:mannai_user_app/views/onboarding/about_view.dart';
import 'package:mannai_user_app/views/onboarding/languange_view.dart';
import 'package:mannai_user_app/views/onboarding/welcome_view.dart';
import 'package:mannai_user_app/views/screens/AllService.dart';
import 'package:mannai_user_app/views/screens/CustomSplashScreen.dart';
import 'package:mannai_user_app/views/screens/ServiceRequest.dart';
import 'package:mannai_user_app/views/screens/create_service_request.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
       GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const CustomSplashScreen(),
    ),
    GoRoute(
      path: RouteNames.language,
      builder: (context, state) => const LanguangeView(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: RouteNames.Account,
      builder: (context, state) => const AccountDetails(),
    ),
    GoRoute(
      path: RouteNames.about,
      builder: (context, state) => const AboutView(),
    ),
    GoRoute(
      path: RouteNames.allservice,
      builder: (context, state) => const Allservice(),
    ),
    GoRoute(
      path: RouteNames.accountverfy,
      builder: (context, state) => const AccountVerification(),
    ),
    GoRoute(
      path: RouteNames.creterequest,
      builder: (context, state) => CreateServiceRequest(),
    ),
    GoRoute(
      path: RouteNames.uploadcard,
      builder: (context, state) => UploadIdView(),
    ),
    GoRoute(
      path: RouteNames.welcome,
      builder: (context, state) => WelcomeView(),
    ),
     GoRoute(
      path: RouteNames.serviceRequestDetails,
      builder: (context, state) => ServiceRequestDetails(),
    ),

GoRoute(
  name: RouteNames.stepper,  
  path: RouteNames.stepper,   
  builder: (context, state) {
    final accountType = state.extra as String? ?? "Individual";
    return AccountStepper(accountType: accountType);
  },
),

    GoRoute(
      path: RouteNames.servicerequestsubmitted,
      builder: (context, state) => Servicerequest(),
    ),
    GoRoute(
      path: RouteNames.Terms,
      builder: (context, state) => Termsandconditions(),
    ),
    GoRoute(
      path: RouteNames.accountcreated,
      builder: (context, state) => Accountcreated(),
    ),
    GoRoute(builder: (context, state) => Otp(), path: RouteNames.opt),

    GoRoute(
      path: RouteNames.pointdetails,
      builder: (context, state) => PointDetails(),
      ),
    GoRoute(
      path: RouteNames.bottomnav,
      builder: (context, state) => const BottomNav(),
    ),
  ],
);
