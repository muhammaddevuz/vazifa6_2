import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/group_bloc/group_bloc.dart';
import 'package:vazifa/blocs/current_user_bloc/current_user_bloc.dart';
import 'package:vazifa/blocs/room_bloc.dart/room_bloc.dart';
import 'package:vazifa/blocs/subject_bloc/subject_bloc.dart';
import 'package:vazifa/blocs/timetable_bloc/timetable_bloc.dart';
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
        BlocProvider(create: (context) => GroupBloc()),
        BlocProvider(create: (context) => RoomBloc()),
        BlocProvider(create: (context) => TimetableBloc()),
        BlocProvider(create: (context) => SubjectBloc())
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
                  } else if (state is AuthErrorState) {
                    if (state.error == 'register') {
                      return SignUpScreen();
                    } else {
                      print("ssssssss");
                      return SignInScreen();
                    }
                  } else {
                    return SignInScreen();
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
