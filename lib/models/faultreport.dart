import 'package:cloud_firestore/cloud_firestore.dart';

class FaultReportModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const LAT = "lat";
  static const LNG = "lng";
  static const LOCATION = "location";
  static const DESCRIPTION = "description";
  static const FAULTTYPE = "faulttype";
  static const USERID = "userId";
  static const CREATED_AT = "createdAt";
  static const STATUS = "status";
  static const DEPARTMENT = "department";
  static const URGENCY = "urgency";
  static const STREETLIGHTNO = "streetlightno";

  String _id;
  String _image;
  double _lat;
  double _lng;
  String _location;
  String _description;
  String _faulttype;
  String _userId;
  String _status;
  String _department;
  String _urgency;
  String _streetlightno;
  int _createdAt;

  //getters
  String get id => _id;
  String get image => _image;
  double get lat => _lat;
  double get lng => _lng;
  String get location => _location;
  String get description => _description;
  String get faulttype => _faulttype;
  String get userId => _userId;
  String get status => _status;
  String get department => _department;
  String get urgency => _urgency;
  String get streetlightno => _streetlightno;
  int get createdAt => _createdAt;

  FaultReportModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _lat = snapshot.data[LAT];
    _lng = snapshot.data[LNG];
    _location = snapshot.data[LOCATION];
    _description = snapshot.data[DESCRIPTION];
    _faulttype = snapshot.data[FAULTTYPE];
    _userId = snapshot.data[USERID];
    _createdAt = snapshot.data[CREATED_AT];
    _department = snapshot.data[DEPARTMENT];
    _status = snapshot.data[STATUS];
    _urgency = snapshot.data[URGENCY];
    _streetlightno = snapshot.data[STREETLIGHTNO];
  }
}
