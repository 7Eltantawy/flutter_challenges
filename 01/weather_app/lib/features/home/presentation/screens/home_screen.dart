import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';
import 'package:weather_app/features/home/presentation/screens/full_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController cityNameController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    cityNameController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    cityNameController.dispose();
    super.dispose();
  }

  Future<void> getDetails() async {
    if (formKey.currentState!.validate()) {
      context
          .read<WeatherBloc>()
          .add(GetWeatherDetailsEvent(cityNameController.text.trim()));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return FullDetailsScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "City Name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextFormField(
                    controller: cityNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter city name for example "London"',
                    ),
                    validator: (value) => value!.trim().isEmpty
                        ? "City name cannot be empty"
                        : null,
                  ),
                ],
              ),
              SizedBox(height: 30),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                onPressed: () => getDetails(),
                child: Text("Get Details"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
