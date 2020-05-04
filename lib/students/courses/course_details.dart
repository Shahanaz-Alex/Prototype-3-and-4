import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tenjin/teacher/models/documents.dart';
import 'package:tenjin/teacher/service/studentServices.dart';

class CourseDetails extends StatefulWidget {

  List list;
  int index;
  CourseDetails({this.index,this.list});


  @override
  _CourseDetailsState createState() => new _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  List<Document> _documents;
  String coursecode;

  @override
  void initState(){
    super.initState();
    coursecode;
    _documents = [];
    _getDocuments(coursecode);
  }

  _getDocuments(coursecode){
    StudentServices.getDocuments(coursecode).then((documents){
      setState(() {
        _documents = documents;
      });
      print('Length ${documents.length}');
    });
  }

  SingleChildScrollView _dataBody(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'COURSE CODE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'DOCUMENT NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'UNLOCK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ], //columns
          rows: _documents
              .map(
                  (document) => DataRow(cells:[
                DataCell(
                  Container(
                      width: 75,
                      child: Text(
                        document.courseid.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  Container(
                      width: 100,
                      child: Text(
                        document.fileName.toUpperCase(),
                      )
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(
                        Icons.lock,
                        color: Colors.redAccent,
                    ),
                    onPressed: (){
                      //unlock functionality goes here
                    },
                  ),
                ),
              ])
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['CourseID']}"),
        backgroundColor: Colors.amber[400],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Refresh Contents',
          onPressed: (){
            print(widget.list[widget.index]['CourseID'].toString());
            _getDocuments(widget.list[widget.index]['CourseID'].toString());
          },
        ),
        ],
      ),
     body:Container(
       child: _dataBody(),
     )

    );
  }
}