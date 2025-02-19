import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                    validator: (value) =>
                        value!.isEmpty ? "City name cannot be empty" : null,
                  ),
                ],
              ),
              SizedBox(height: 30),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(title: Text(cityNameController.text)),
                      );
                    }));
                  }
                },
                child: Text("Get Details"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
