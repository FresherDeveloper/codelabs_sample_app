import 'dart:developer';

import 'package:coinone_sample_app/domain/use_cases/sign_in_use_case.dart';
import 'package:coinone_sample_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:coinone_sample_app/presentation/bloc/product/product_bloc.dart';
import 'package:coinone_sample_app/presentation/views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(context.read<SignInUseCase>()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(context.read<SignInUseCase>()),
        ),
      ],
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 25, 41),
        foregroundColor: Colors.white,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final authBloc = BlocProvider.of<AuthBloc>(context);
              authBloc.add(SignOutRequested());
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Sign out successful!",
                ),
              ));
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error != null) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else if (state.dataList.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: state.dataList.length,
              itemBuilder: (context, index) {
                final item = state.dataList[index];
                log("https://coinoneglobal.in/crm/${item['ImgUrlPath']}");

                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   '/detail',
                    //   arguments: item["id"],
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: item),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: item['ImgUrl'] != null
                              ? Hero(
                                  tag: 'image${item['Id']}',
                                  child: Image.network(
                                    "https://coinoneglobal.in/crm/${item['ImgUrlPath']}",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Placeholder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['Name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
