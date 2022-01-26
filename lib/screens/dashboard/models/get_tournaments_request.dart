class GetTournamentsRequest {
  int? limit;
  String? status;
  String? cursor;

  GetTournamentsRequest({this.limit= 10, this.status = "all", this.cursor = ""});


  GetTournamentsRequest.fromJson(Map<String, dynamic> json) {
    limit = json["limit"];
    status = json["status"];
    cursor = json["cursor"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["limit"] = limit;
    data["status"] = status;
    data["cursor"] = cursor;
    return data;
  }
}
