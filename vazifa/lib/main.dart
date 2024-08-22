import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:vazifa/blocs/users_bloc/users_bloc.dart';
import 'package:vazifa/ui/screens/managment_screen.dart';
import 'package:vazifa/ui/screens/auth_screen/signin_screen.dart';
import 'package:vazifa/ui/screens/auth_screen/signup_for_teacher.dart';
import 'package:vazifa/ui/screens/auth_screen/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AppStarted())),
        BlocProvider(create: (context) => CurrentUserBloc()),
        BlocProvider(create: (context) => UsersBloc()),
        BlocProvider(create: (context) => GroupBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC Auth',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return ManagmentScreen();
                  } else if (state is UnauthenticatedState) {
                    return SignInScreen();
                  } else {
                    return Scaffold(
                        body: Center(child: CircularProgressIndicator()));
                  }
                },
              ),
          '/signup': (context) => SignUpScreen(),
          '/signupteacher': (context) => SignupForTeacher(),
          '/home': (context) => ManagmentScreen(),
        },
      ),
    );
  }
}
