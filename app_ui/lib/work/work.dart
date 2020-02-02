class Work {
  int idDb;
  String idUsersGiver;
  String workDes;
  String pickup;
  String dropPoint;
  String garuda;
  int workStatus;
  String idUsersDoer;
  String timePosted;
  int timeLimit;
  String remarks;
  int otp;
  int phoneNo;
  int aceepted;

  Work(
      {this.idDb,
      this.idUsersGiver,
      this.workDes,
      this.pickup,
      this.dropPoint,
      this.garuda,
      this.workStatus,
      this.idUsersDoer,
      this.timePosted,
      this.timeLimit,
      this.remarks,
      this.otp,
      this.phoneNo,
      this.aceepted});

  Work.fromJson(Map<String, dynamic> json) {
    idDb = json['id_db'];
    idUsersGiver = json['id_users_giver'];
    workDes = json['work_des'];

    pickup = json['pickup'];
    dropPoint = json['drop_point'];
    garuda = json['garuda'].toString();
    workStatus = json['work_status'];
    idUsersDoer = json['id_users_doer'];
    timePosted = json['time_posted'];
    timeLimit = json['time_limit'];
    remarks = json['remarks'];
    otp = json['otp'];
    phoneNo = json['phone_no'];
    aceepted = json['aceepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_db'] = this.idDb;
    data['id_users_giver'] = this.idUsersGiver;
    data['work_des'] = this.workDes;
    data['pickup'] = this.pickup;
    data['drop_point'] = this.dropPoint;
    data['garuda'] = this.garuda.toString();
    data['work_status'] = this.workStatus;
    data['id_users_doer'] = this.idUsersDoer;
    data['time_posted'] = this.timePosted;
    data['time_limit'] = this.timeLimit;
    data['remarks'] = this.remarks;
    data['otp'] = this.otp;
    data['phone_no'] = this.phoneNo;
    data['aceepted'] = this.aceepted;
    return data;
  }
}
