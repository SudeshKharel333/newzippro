class LoginResponse {
  String? status;
  String? errorCode;
  String? message;
  String? attendance;
  User? user;
  String? token;

  LoginResponse(
      {this.status,
        this.errorCode,
        this.message,
        this.attendance,
        this.user,
        this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error code'];
    message = json['message'];
    attendance = json['attendance'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['error code'] = this.errorCode;
    data['message'] = this.message;
    data['attendance'] = this.attendance;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? areas;
  String? subAreas;
  int? roleId;
  int? vehicletypeId;
  String? fcmId;
  String? status;
  String? lastSeen;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.areas,
        this.subAreas,
        this.roleId,
        this.vehicletypeId,
        this.fcmId,
        this.status,
        this.lastSeen});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    areas = json['areas'];
    subAreas = json['sub_areas'];
    roleId = json['role_id'];
    vehicletypeId = json['vehicletype_id'];
    fcmId = json['fcm_id'];
    status = json['status'];
    lastSeen = json['last_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['areas'] = this.areas;
    data['sub_areas'] = this.subAreas;
    data['role_id'] = this.roleId;
    data['vehicletype_id'] = this.vehicletypeId;
    data['fcm_id'] = this.fcmId;
    data['status'] = this.status;
    data['last_seen'] = this.lastSeen;
    return data;
  }
}
