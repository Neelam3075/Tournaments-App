class LoginResponse {
  String? id;
  String? email;
  bool? active;
  String? name;
  String? username;
  String? password;
  int? tounamentPlay;
  int? tournamentWon;
  String? profile;
  bool? status;
  String? message;

  LoginResponse({
    this.id,
    this.email,
    this.active,
    this.name,
    this.username,
    this.password,
    this.tounamentPlay,
    this.tournamentWon,
    this.profile,
    this.status,
    this.message,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    email = json['email'] as String?;
    active = json['active'] as bool?;
    name = json['name'] as String?;
    username = json['username'] as String?;
    password = json['password'] as String?;
    tounamentPlay = json['tounamentPlay'] as int?;
    tournamentWon = json['tournamentWon'] as int?;
    profile = json['profile'] as String?;
    status = json['status'] as bool?;
    message = json['message'] as String?;
  }

  getPercentage() => (((tournamentWon ?? 0) * 100) / (tounamentPlay ?? 0)).toString();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['email'] = email;
    json['active'] = active;
    json['name'] = name;
    json['username'] = username;
    json['password'] = password;
    json['tounamentPlay'] = tounamentPlay;
    json['tournamentWon'] = tournamentWon;
    json['profile'] = profile;
    json['status'] = status;
    json['message'] = message;
    return json;
  }
}
