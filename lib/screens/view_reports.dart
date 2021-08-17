import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_admin/helpers/screen_navigation.dart';
import 'package:fyp_admin/helpers/style.dart';
import 'package:fyp_admin/models/faultreport.dart';
import 'package:fyp_admin/models/user.dart';
import 'package:fyp_admin/providers/app.dart';
import 'package:fyp_admin/providers/faultreport.dart';
import 'package:fyp_admin/providers/user.dart';
import 'package:fyp_admin/screens/details.dart';
import 'package:fyp_admin/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewReportsScreen extends StatelessWidget {
  final FaultReportModel faultreport;

  const ViewReportsScreen({Key key, this.faultreport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faultreportprovider = Provider.of<FaultReportProvider>(context);
    final app = Provider.of<AppProvider>(context);
    faultreportprovider.loadFaultReports();
    faultreportprovider.faultreports.sort((a, b) => b.createdAt - a.createdAt);
    for (var s in faultreportprovider.faultreports) {
      if (s.status == "Completed" || s.status == "Rejected") {
        faultreportprovider.faultreports
            .insert(faultreportprovider.faultreports.length, s);
        faultreportprovider.faultreports.remove(s);
      }
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          elevation: 10.0,
          centerTitle: true,
          title: CustomText(text: "View All Reports", size: 20),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              itemCount: faultreportprovider.faultreports.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                FaultReportModel _faultreport =
                    faultreportprovider.faultreports[index];

                return faultreportprovider.faultreports.length != 0
                    ? GestureDetector(
                        onTap: () {
                          changeScreen(
                              context,
                              Details(
                                  faultreport:
                                      faultreportprovider.faultreports[index],
                                  index: index));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _faultreport.urgency == "High" &&
                                              _faultreport.status != "Completed"
                                          ? Colors.red
                                          : Colors.white.withOpacity(0)),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: faultreportprovider
                                                      .faultreports[index]
                                                      .status ==
                                                  "Completed" ||
                                              faultreportprovider
                                                      .faultreports[index]
                                                      .status ==
                                                  "Rejected"
                                          ? Colors.grey.withOpacity(0.5)
                                          : Colors.grey.withOpacity(0),
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                              // REPORT IMAGE
                                              child: Container(
                                                  width: 130.0,
                                                  height: 130.0,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(20),
                                                      ),
                                                      child: Hero(
                                                        tag: index,
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl: _faultreport
                                                              .image,
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Icon(
                                                                  Icons.error),
                                                        ),
                                                      ))
                                                  // child: Image.asset(
                                                  //     'images/pothole.jpg')),
                                                  ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  //REPORT FAULT CREATED AT
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text(
                                                      DateFormat(
                                                              'd MMMM yyyy, hh:mm aaa')
                                                          .format(DateTime
                                                                  .fromMillisecondsSinceEpoch(
                                                                      _faultreport
                                                                          .createdAt)
                                                              .add(Duration(
                                                                  hours:
                                                                      8))) //add to gmt+8
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Expanded(
                                                  // REPORT FAULT LOCATION
                                                  child: new Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 230),
                                                    padding:
                                                        new EdgeInsets.only(
                                                            right: 0.0),
                                                    child: new Text(
                                                      _faultreport.location,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: new TextStyle(
                                                        fontSize: 13.0,
                                                        fontFamily: 'Roboto',
                                                        color: new Color(
                                                            0xFF212121),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  //REPORT FAULT TYPE
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
                                                    _faultreport.faulttype,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _faultreport.status,
                                                        style: TextStyle(
                                                            color: _faultreport
                                                                        .status ==
                                                                    "Completed"
                                                                ? Colors.green
                                                                : Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Text(_faultreport.urgency),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10)),
                                      ],
                                    )))),
                      )
                    : Container(color: Colors.blue, height: 250);
              }),
        ));
  }
}

Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(
      BuildContext context, String imagepath) async {
    return await FirebaseStorage.instance
        .ref()
        .child(imagepath)
        .getDownloadURL();
  }
}
