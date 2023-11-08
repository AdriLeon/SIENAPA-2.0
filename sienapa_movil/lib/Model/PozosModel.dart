class PozosModel {
  String? id;
  String? nombre;
  String? convenio;
  int? electricidad;
  String? estado;
  String? ubicacion;
  String? informacion;

  PozosModel(this.id, this.nombre, this.convenio, this.electricidad,
      this.estado, this.ubicacion, this.informacion);

  PozosModel.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    convenio = json['convenio'];
    electricidad = json['electricidad'];
    estado = json['estado'];
    ubicacion = json['ubicacion'];
    informacion = json['informacion'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['convenio'] = convenio;
    data['electricidad'] = electricidad;
    data['estado'] = estado;
    data['ubicacion'] = ubicacion;
    data['informacion'] = informacion;
    return data;
  }
}
