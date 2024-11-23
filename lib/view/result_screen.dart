import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResultScreen extends StatelessWidget {
  final List<String> inputs;

  const ResultScreen({super.key, required this.inputs});

  Future<void> _generateAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Your Results:',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              ...inputs.asMap().entries.map(
                    (entry) => pw.Text('Input ${entry.key + 1}: ${entry.value}'),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Results:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...inputs.asMap().entries.map(
                  (entry) => Text('Input ${entry.key + 1}: ${entry.value}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _generateAndPrintPdf(context),
              child: const Text("Print & Save PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
