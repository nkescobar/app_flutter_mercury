import 'package:flutter/material.dart';
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
// Shared
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show ButtonMainActionPositiveWidget;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: AppStyles.paddingXL),
                  child: Text(
                    'Bienvenido',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonMainActionPositiveWidget(
                    text: 'Categorias',
                    onPressed: () => _navegarCategory(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navegarCategory() {
    Navigator.pushNamed(context, AppRoutes.categoriesRoute);
  }
}
