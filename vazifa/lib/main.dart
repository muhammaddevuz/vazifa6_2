import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/blocs/auth_bloc/auth_bloc.dart';
import 'package:vazifa/blocs/user_bloc/user_bloc.dart';
import 'package:vazifa/ui/screens/home_screen.dart';
import 'package:vazifa/ui/screens/signin_screen.dart';
import 'package:vazifa/ui/screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AppStarted())),
        BlocProvider(create: (context) => UserBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC Auth',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return HomeScreen();
                  } else if (state is UnauthenticatedState) {
                    return SignInScreen();
                  } else {
                    return Scaffold(
                        body: Center(child: CircularProgressIndicator()));
                  }
                },
              ),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
