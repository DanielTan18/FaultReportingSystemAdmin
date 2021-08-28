import 'package:flutter/material.dart';
import 'package:fyp_admin/helpers/faultreport.dart';

import '../models/faultreport.dart';

class FaultReportProvider with ChangeNotifier {
  FaultReportServices _faultReportServices = FaultReportServices();
  List<FaultReportModel> faultreports = [];
  List<FaultReportModel> faultreportsByUser = [];
  FaultReportModel faultreport;

  FaultReportProvider.initialize() {
    loadFaultReports();
  }

  loadFaultReports() async {
    faultreports = await _faultReportServices.getAllReports();
    notifyListeners();
  }

  loadSingleFaultReport({String faultReportId}) async {
    faultreport =
        await _faultReportServices.getFaultReportById(id: faultReportId);
    notifyListeners();
  }

  Future loadFaultReportsbyUser({String userId}) async {
    faultreportsByUser =
        await _faultReportServices.getUserReports(userId: userId);
    notifyListeners();
  }
}
