import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/presentation/widgets/app_drawer.dart';
import '../controllers/weather_controller.dart';
import '../routes/app_routes.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final controller = Get.find<WeatherController>();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadEvents('Bogotá');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Events Weather'),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.events.length,
          itemBuilder: (_, index) {
            final event = controller.events[index];

            return ListTile(
              title: Text(event.title),
              subtitle: Text(event.type),
              onTap: () {
                Get.toNamed(
                  Routes.eventDetail,
                  arguments: event,
                );
              },
            );
          },
        );
      }),
    );
  }
}