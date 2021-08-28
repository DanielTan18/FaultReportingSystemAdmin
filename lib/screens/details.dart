import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fyp_admin/helpers/faultreport.dart';
import 'package:fyp_admin/helpers/screen_navigation.dart';
import 'package:fyp_admin/helpers/style.dart';
import 'package:fyp_admin/models/faultreport.dart';
import 'package:fyp_admin/screens/gmapscreen.dart';
import 'package:fyp_admin/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class Details extends StatefulWidget {
  final FaultReportModel faultreport;
  final int index;

  const Details({@required this.faultreport, @required this.index});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double widgetOpacity = 0.0;

  List listStatus = ["Open", "Assigned", "Fixed", "Rejected", "Completed"];
  List departmentStatus = [
    "Unassigned",
    "Traffic Dpt.",
    "District Offices",
    "Statutory Bodies",
  ];
  String selectedDepartment;
  String selectedStatus;
  String selectedUrgency;
  FaultReportServices _faultReportServices = FaultReportServices();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      widgetOpacity = 1;
    });
    selectedUrgency = widget.faultreport.urgency;
    selectedDepartment = widget.faultreport.department;
    selectedStatus = widget.faultreport.status;
  }

  setSelectedUrgency(String val) {
    setState(() {
      selectedUrgency = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
                child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  changeScreen(context,
                      FullScreen(widget.faultreport.image, widget.index));
                },
                child: Hero(
                  tag: widget.index,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Ink.image(
                      image: NetworkImage(widget.faultreport.image),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            )),
          ),
          Expanded(
              child: Container(
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: CustomText(
                            text: "Description:",
                            size: 20,
                            weight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
                        child: CustomText(
                          text: widget.faultreport.description,
                          color: Colors.black54,
                        ),
                      ),
                      widget.faultreport.streetlightno.isNotEmpty
                          ? CustomText(
                              text: "Streetlight No.: " +
                                  widget.faultreport.streetlightno,
                              size: 16,
                              color: Colors.black54)
                          : SizedBox(height: 0),
                      Divider(
                        indent: 10,
                        height: 15,
                        endIndent: 35,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          //Row of Assigned To and Status
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3.0),
                                    child: CustomText(
                                        text: "Assigned To:",
                                        size: 18,
                                        weight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Container(
                                            width: 120,
                                            padding:
                                                new EdgeInsets.only(right: 5),
                                            child: Text(
                                                widget.faultreport.department,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 30,
                                          isExpanded: false,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          value: selectedDepartment,
                                          onChanged: (newValue2) {
                                            setSelectedDepartment(newValue2);
                                          },
                                          items:
                                              departmentStatus.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 150),
                                                child: Text(valueItem,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3.0),
                                    child: CustomText(
                                        text: "Status",
                                        size: 18,
                                        weight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text(widget.faultreport.status),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 30,
                                          isExpanded: false,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          value: selectedStatus,
                                          onChanged: (newValue) {
                                            setSelectedStatus(newValue);
                                          },
                                          items: listStatus.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        //Urgency selection
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: CustomText(text: "Urgency: ", size: 18),
                            ),
                            Expanded(
                              child: CustomRadioButton(
                                enableShape: true,
                                elevation: 1,
                                defaultSelected: widget.faultreport.urgency,
                                enableButtonWrap: false,
                                width: 90,
                                autoWidth: false,
                                unSelectedColor: Theme.of(context).canvasColor,
                                buttonLables: ["Low", "Medium", "High"],
                                buttonValues: ["Low", "Medium", "High"],
                                radioButtonValue: (value) {
                                  setSelectedUrgency(value);
                                  print(
                                      "selectedUrgency is " + selectedUrgency);
                                },
                                selectedColor: selectedUrgency == "High"
                                    ? Colors.red
                                    : selectedUrgency == "Medium"
                                        ? Colors.orange
                                        : Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          //Update Button
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  changeScreen(
                                      context,
                                      GmapScreen(
                                          lat: widget.faultreport.lat,
                                          lng: widget.faultreport.lng));
                                },
                                child: CustomText(
                                    text: "Go To Location",
                                    size: 18,
                                    color: white),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                  child: CustomText(
                                    text: "Update",
                                    size: 20,
                                    weight: FontWeight.w400,
                                    color: white,
                                  ),
                                  onPressed: () {
                                    _faultReportServices.updateFaultData(
                                        id: widget.faultreport.id,
                                        status: selectedStatus,
                                        department: selectedDepartment,
                                        urgency: selectedUrgency);
                                    Navigator.pop(context);
                                    Flushbar(
                                      title: "Report Updated",
                                      message:
                                          "Report Details has been updated!",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  }),
                            ],
                          )),
                    ],
                  ),
                ]),
              ),
            ),
          ))
        ])),
        Container(
          margin: EdgeInsets.only(top: 25),
          child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )),
        ),
        AnimatedOpacity(
          opacity: 1,
          duration: Duration(milliseconds: 300),
          child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 30,
                          offset: Offset(0, 10))
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    left: 20.0,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: DateFormat('MMMM dd yyyy, hh:mm aaa')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                          widget.faultreport.createdAt)
                                      .add(Duration(hours: 8))) //add to gmt+8
                                  .toString(),
                              size: 21,
                              weight: FontWeight.bold),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: CustomText(
                                color: red,
                                size: 25,
                                text: widget.faultreport.urgency == "Low"
                                    ? "!"
                                    : widget.faultreport.urgency == "Medium"
                                        ? "!!"
                                        : widget.faultreport.urgency == "High"
                                            ? "!!!"
                                            : ""),
                          ),
                        ],
                      ),
                      CustomText(text: widget.faultreport.faulttype),
                      CustomText(
                          text: widget.faultreport.location,
                          color: Colors.black38,
                          weight: FontWeight.bold,
                          size: 14),
                    ],
                  ),
                ),
              )),
        ),
      ]),
    );
  }

  void setSelectedDepartment(newValue2) {
    return setState(() {
      selectedDepartment = newValue2;
      if (selectedDepartment != "Unassigned") {
        selectedStatus = "Assigned";
      } else {
        selectedStatus = "Open";
      }
      print("selectedDepartment is " + selectedDepartment);
    });
  }

  void setSelectedStatus(newValue) {
    return setState(() {
      selectedStatus = newValue;
      if (selectedStatus == "Open") {
        selectedDepartment = "Unassigned";
      }
      print("selectedStatus is " + selectedStatus);
    });
  }
}

class FullScreen extends StatelessWidget {
  FullScreen(this.imageurl, this.index);
  final String imageurl;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: index,
            child: Card(
              margin: EdgeInsets.all(0),
              child: Ink.image(
                height: MediaQuery.of(context).size.height,
                image: NetworkImage(imageurl),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
