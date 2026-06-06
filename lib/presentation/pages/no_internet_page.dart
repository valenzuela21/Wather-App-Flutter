import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),

              const Text(
                "Sin conexión a Internet",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Revisa tu conexión WiFi o datos móviles e intenta nuevamente.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Get.back(); // vuelve a pantalla anterior
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Reintentar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}