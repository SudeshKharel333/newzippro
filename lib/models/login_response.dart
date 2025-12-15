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
    //LoginResponse.fromJson(Map<String, dynamic> json)
//This is a named constructor in Dart.fromJson This method
    //takes the data coming from the server
    //in JSON format) and fills up the variables in this class.
    status = json['status'];
    errorCode = json['error code'];
    message = json['message'];
    attendance = json['attendance'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    //toJson This does the opposite: It converts
    // your object back to JSON,
    //so it can be sent to a server.

    final Map<String, dynamic> data = <String, dynamic>{};
    //final-	This means the variable data can’t be reassigned later
    ////(you can add items inside it, but you can't do data = anotherMap)
    //Map<String, dynamic>	This is the type of the map. It holds
    //key-value pairs where:
    // Keys are String (like "name", "email")
    // Values can be anything (dynamic)
    //data	-This is the name of the variable you're creating
    //= <String, dynamic>{};	This is the initial value, which
    //is an empty map with type <String, dynamic>

    data['status'] = this.status;
    data['error code'] = this.errorCode;
    data['message'] = this.message;
    data['attendance'] = this.attendance;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    } //“If the user object is not empty, then convert that user object
    // into a map using .toJson() and store it in the main data map under
    // the key 'user'.”
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
