import 'package:app_mercury_flutter/entrypoint/application/config/index.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart';
import 'package:flutter/material.dart';

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
                Padding(
                  padding: const EdgeInsets.only(top: AppStyles.paddingXL),
                  child: Container(
                    child: const Text(
                      'Bienvenido',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BotonAccionPrincipalPositivaWidget(
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
