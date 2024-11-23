import 'package:flutter/material.dart';
import 'result_screen.dart';

class FormScreenPage extends StatefulWidget {
  const FormScreenPage({super.key});

  @override
  State<FormScreenPage> createState() => _FormScreenPageState();
}

class _FormScreenPageState extends State<FormScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(
    10,
        (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final inputs = _controllers.map((c) => c.text).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(inputs: inputs),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ..._controllers.asMap().entries.map(
                      (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: 'Input ${entry.key + 1}',
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
