import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usuarios extends GetView {
  const Usuarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Usuarios')),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: DataTable(columns: [
          const DataColumn(
              label: SizedBox(
            width: 30,
          )),
          DataColumn(
              label: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: const Text(
              'Correo',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.lightBlue),
              textAlign: TextAlign.center,
            ),
          )),
          DataColumn(
            label: SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: const Text(
                'Nivel',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.lightBlue),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ], rows: [
          DataRow(cells: [
            DataCell(const Icon(Icons.person), ),
            DataCell(const Text('operador@sienapa.com')),
            DataCell(const Text('operador'),),
          ],
          onLongPress: ( ){
            _mostrarDialog(context);
          },
          ),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('operador@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('operador'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('administrador@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('administrador'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('informatica@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('informatica'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('operador@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('operador'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('administrador@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('administrador'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
          DataRow(cells: [
            DataCell(const Icon(Icons.person), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('informatica@sienapa.com'), onTap: (){
              _mostrarDialog(context);
            }),
            DataCell(const Text('informatica'), onTap: (){
              _mostrarDialog(context);
            }),
          ]),
        ]),
      )),
    );
  }
}

void _mostrarDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Información del Usuario'),
      content: Text('Nivel: Administrador\nCorreo: '),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cerrar');
          },
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}