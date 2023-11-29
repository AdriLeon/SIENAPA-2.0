import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({Key? key}) : super(key: key);

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  List<String> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    getPdfList().then((files) {
      setState(() {
        pdfFiles = files.map((file) => file.name).toList();
      });
    });
  }

  Future<List<Reference>> getPdfList() async {
    final storage = FirebaseStorage.instance;
    final reference = storage.ref('/data/reportes');
    final files = await reference.listAll();

    return files.items;
  }

  Future<void> downloadPdf(String fileName) async {
    // Verificar y solicitar permisos
    var status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
      if (status.isDenied) {
        // El usuario no otorgó permisos, puedes mostrar un mensaje o hacer algo en consecuencia.
        return;
      }
    }

    try {
      final storage = FirebaseStorage.instance;
      final reference = storage.ref('/data/reportes/$fileName');
      final fileData = await reference.getData();

      if (!fileName.toLowerCase().endsWith('.pdf')) {
        fileName = '$fileName.pdf';
      }

      final directory = await getDownloadsDirectory();
      final filePath = '${directory!.path}/$fileName';

      final fileToSave = File(filePath);

      await fileToSave.writeAsBytes(fileData!);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:
          Text('File downloaded successfully'),
            action: SnackBarAction(
              label: 'Abrir',
              onPressed: () {
                openFile(fileToSave.path);
              },
            ),
          ));


      print('File saved at: $filePath');
    } catch (error) {
      print('Error downloading file: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading file: $error'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reportes')),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          final fileName = pdfFiles[index];
          return ListTile(
            title: Text(fileName),
            onTap: () {
              downloadPdf(fileName);
            },
          );
        },
      ),
    );
  }
}

void openFile(String filePath) async {
  // Asegúrate de manejar el caso en el que el archivo no exista
  if (await File(filePath).exists()) {
    // Abre el archivo con la aplicación predeterminada
    await OpenFile.open(filePath);
  } else {
    print('El archivo no existe');
  }
}