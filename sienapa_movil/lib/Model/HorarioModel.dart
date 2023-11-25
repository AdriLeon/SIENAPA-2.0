class HorarioModel{
  String? id;
  String? nombre;
  String? estado;
  int? dia1;
  int? dia2;
  int? dia3;
  int? dia4;
  int? dia5;
  int? dia6;
  int? dia7;
  String? h_apagado;
  String? h_encendido;

  HorarioModel(this.id, this.nombre, this.estado, this.dia1, this.dia2, this.dia3, this.dia4, this.dia5, this.dia6, this.dia7, this.h_apagado, this.h_encendido);

  HorarioModel.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    estado = json['estado'];
    dia1 = json['dia1'];
    dia2 = json['dia2'];
    dia3 = json['dia3'];
    dia4 = json['dia4'];
    dia5 = json['dia5'];
    dia6 = json['dia6'];
    dia7 = json['dia7'];
    h_apagado = json['h_apagado'];
    h_encendido = json['h_encendido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['estado'] = estado;
    data['dia1'] = dia1;
    data['dia2'] = dia2;
    data['dia3'] = dia3;
    data['dia4'] = dia4;
    data['dia5'] = dia5;
    data['dia6'] = dia6;
    data['dia7'] = dia7;
    data['h_apagado'] = h_apagado;
    data['h_encendido'] = h_encendido;
    return data;
  }
}
