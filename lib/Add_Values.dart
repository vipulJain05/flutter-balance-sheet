import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'services/services.dart';

class AddDetails extends StatefulWidget {
  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  var _key = GlobalKey<FormState>();
  CrudServices crudService = CrudServices();
  TextEditingController _name = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _description = TextEditingController();
  InputType inputType = InputType.date;
  DateTime date;
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  var _option = ['REVENUE', 'EXPENDITURE'];
  var _selected = '';
  @override
  void initState() {
    _selected = _option[0];
    super.initState();
  }

  var _res;
// @override
// void dispose() {
//     _name.dispose();
//     _date.dispose();
//     _amount.dispose();
//     _description.dispose();
//     super.dispose();
//   }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add Details"),
            leading: IconButton(icon: Icon( Icons.arrow_back),
             onPressed: () {
               Navigator.pop(context);
             },),
          ),
          body: Form(
            key: _key,
            child: ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: DropdownButton(
                  items: _option.map((String values) {
                    return DropdownMenuItem(
                      value: values,
                      child: Text(values),
                    );
                  }).toList(),
                  value: _selected,
                  onChanged: (String valueSelected) {
                    onchangeOption(valueSelected);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: _name,
                  autofocus: true,
                  validator: (String data) {
                    if (data.isEmpty == true) {
                      return "Enter Name of product";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Name of Product",
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      )),
                  // onEditingComplete: (){
                  //   _name.text =_name
                  // },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: DateTimePickerFormField(
                  controller: _date,
                  inputType: inputType,
                  format: formats[inputType],
                  editable: false,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hasFloatingPlaceholder: false,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (dt) => setState(() => date = dt),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amount,
                  autofocus: true,
                  validator: (String data) {
                    if (data.isEmpty == true) {
                      return "Enter Amount";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter Amount",
                      hintText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 10.0,
                      )),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextFormField(
                      controller: _description,
                      decoration: InputDecoration(
                        labelText: "Enter Description of Product",
                        hintText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ))
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Colors.blue,
                              splashColor: Colors.tealAccent,
                              shape: BeveledRectangleBorder(),
                              child: Text('Submit'),
                              onPressed: (){
                                //Navigator.pop(context);
                                if(_key.currentState.validate() ==true){
                                  AlertDialog alert = AlertDialog(
                                  backgroundColor: Colors.lightGreen,
                                  title: Text('Successfull'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("OK"), 
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // _res = _date.text.split('-');
                                        // Map<String,dynamic> data = {'choice' : _selected, 'name':_name.text,'date': _res[2],'month' : _res[1],'year' : _res[0],'amount':_amount.text,'description':_description.text};
                                        Map<String,dynamic> data = {'choice' : _selected, 'name':_name.text,'date': _date.text,'amount':_amount.text,'description':_description.text};
                                        crudService.addData(data).catchError((error) => SnackBar(content: Text('$error')));
                                      },

                                    )
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (_) => alert
                                );
                                } 
                              },
                            ),
                          ),
                          Container(
                      width: 2.0,
                    ),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.blue,
                              splashColor: Colors.red,
                              shape: BeveledRectangleBorder(),
                              child: Text('Reset'),
                              onPressed: (){
                                _name.text = '';
                                _date.text = '';
                                _amount.text = '';
                                _description.text = '';
                                _selected = _option[0];
                              },
                            ),
                          ),
                        ],
                      ),
                    )
            ]),
          )),
    );
  }

  void onchangeOption(String selectedValue) {
    setState(() {
      _selected = selectedValue;
    });
  }
}
