import 'package:coinone_sample_app/data/data_sources/firebase_auth_data_source.dart';
import 'package:coinone_sample_app/data/repositories/auth_repository_impl.dart';
import 'package:coinone_sample_app/domain/use_cases/sign_in_use_case.dart';
import 'package:coinone_sample_app/firebase_options.dart';
import 'package:coinone_sample_app/presentation/views/detail_screen.dart';
import 'package:coinone_sample_app/presentation/views/home_screen.dart';
import 'package:coinone_sample_app/presentation/views/login_screen.dart';
import 'package:coinone_sample_app/presentation/views/splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthDataSource(FirebaseAuth.instance)),
        ProxyProvider<FirebaseAuthDataSource, AuthRepositoryImpl>(
          update: (_, dataSource, __) => AuthRepositoryImpl(dataSource),
        ),
        ProxyProvider<AuthRepositoryImpl, SignInUseCase>(
          update: (_, repo, __) => SignInUseCase(repo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Clean Architecture',
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomePageWrapper(),
          '/detail': (context) => const DetailScreen(),
        },
      ),
    );
  }
}
