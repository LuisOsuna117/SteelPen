import 'package:flutter/cupertino.dart';

class AddForm extends StatefulWidget {
  final int items;

  AddForm({this.items});

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.items * 30).toDouble(),
      child: ListView.builder(
        itemCount: widget.items,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Cola')
                    ],
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Cola')
                    ],
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
