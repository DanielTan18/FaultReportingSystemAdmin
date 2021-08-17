import 'package:flutter/material.dart';
import 'package:fyp_admin/models/faultreport.dart';
import 'package:fyp_admin/providers/faultreport.dart';
import 'package:provider/provider.dart';

class FaultReportWidget extends StatelessWidget {
  final FaultReportModel faultreport;

  const FaultReportWidget({Key key, this.faultreport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faultReportProvider = Provider.of<FaultReportProvider>(context);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: myDetailsContainer(),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight,
                          image: NetworkImage(faultreport.image),
                        ),
                      ),
                    )
                  ])),
        )));
  }

  Widget myDetailsContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Candy Bliss",
            style: TextStyle(
                color: Color(0xffe6020a),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.3",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                  child: Text(
                "(321) \u00B7 0.9 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
        ),
        Container(
            child: Text(
          "Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
}
