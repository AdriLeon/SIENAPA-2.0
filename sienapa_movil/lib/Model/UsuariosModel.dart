class UserModel {
  String? id;
  String? email;
  String? nivel;
  dynamic logs;

  UserModel(this.id, this.email, this.nivel, this.logs);

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nivel = json['nivel'];
    logs = json['logs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['nivel'] = nivel;
    data['logs'] = logs;
    return data;
  }
}