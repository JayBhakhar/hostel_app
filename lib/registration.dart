import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController name = TextEditingController();
  TextEditingController surename = TextEditingController();
  TextEditingController fathername = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  String course;
  String faculty;
  TextEditingController group = TextEditingController();
  String hostel_no;
  TextEditingController room_no = TextEditingController();
  String position;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _dropdownErrorFaculty;
  String _dropdownErrorCourse;
  String _dropdownErrorHostel;
  String _dropdownErrorPosition;

  _makePostRequest() async {
    // set up POST request arguments
    final url = Uri.parse('http://192.168.137.1:5000//registration');
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{'
        '"name": "${name.text}",'
        '"surename": "${surename.text}",'
        '"fatherName": "${fathername.text}",'
        '"phoneNo": "${phone_no.text}",'
        '"email": "${email.text}",'
        '"password": "${password.text}",'
        '"confirmPassword": "${confirmpassword.text}",'
        '"faculty": "$faculty",'
        '"course": "$course",'
        '"group": "${group.text}",'
        '"hostelNo": "$hostel_no",'
        '"roomNo": "${room_no.text}",'
        '"position": "$position"'
        '}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
    //   {
    //   name: 'jay',
    //   surename: 'jaybhakhar@gmail.com',
    //   fatherName: '123456'
    //   faculty: 1,
    //   course: 2,
    //   group: 'ap-31',
    //   phoneNo: '+79961011395',
    //   email: 'jaybhakhar@gmail.com',
    //   password: '123465',
    //   confirmPassword: '123456', #while not ready forget password
    //   hostelNo: 1,
    //   roomNo: 12,
    //   position: 1
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Name',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: surename,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Surename ',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Surename';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: fathername,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Father Name',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Father Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: phone_no,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Phone No',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter phone no';
                          } else if (value.length != 10) {
                            return 'Please enter 10 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Email',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Password',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: confirmpassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Confirm Password',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          if (password.text != confirmpassword.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                55, //gives the height of the dropdown button
                            width: MediaQuery.of(context)
                                .size
                                .width, //gives the width of the dropdown button
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Color(0xFFF2F2F2)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(
                                    0xFFF2F2F2), // background color for the dropdown items
                                buttonTheme: ButtonTheme.of(context).copyWith(
                                  alignedDropdown: true,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  iconSize: 32,
                                  iconEnabledColor: Color(
                                      0xFF595959), // icon color of the dropdown button
                                  items: [
                                    'Филологический факультет',
                                    'Факультет башкирской и тюркской филологии',
                                    'Исторический факультет',
                                    'Факультет математики и информационных технологий',
                                    'Естественнонаучный факультет',
                                    'Факультет педагогики и психологии',
                                    'Экономический факультет',
                                    'Юридический факультет',
                                    'Колледж'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select your Faculty',
                                    style: TextStyle(
                                        color: Color(0xFF8B8B8B), fontSize: 15),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      faculty =
                                          value; // saving the selected value
                                      _dropdownErrorFaculty = null;
                                    });
                                  },
                                  value: faculty,
                                  // displaying the selected value
                                ),
                              ),
                            ),
                          ),
                          _dropdownErrorFaculty == null
                              ? SizedBox.shrink()
                              : Text(
                                  _dropdownErrorFaculty ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                55, //gives the height of the dropdown button
                            width: MediaQuery.of(context)
                                .size
                                .width, //gives the width of the dropdown button
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Color(0xFFF2F2F2)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(
                                    0xFFF2F2F2), // background color for the dropdown items
                                buttonTheme: ButtonTheme.of(context).copyWith(
                                  alignedDropdown: true,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                // to hide the default underline of the dropdown button
                                child: DropdownButton<String>(
                                  iconEnabledColor: Color(
                                      0xFF595959), // icon color of the dropdown button
                                  items: [
                                    'первый',
                                    'второй',
                                    'третий',
                                    'четвёртый',
                                    'пятый'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select your Course',
                                    style: TextStyle(
                                        color: Color(0xFF8B8B8B), fontSize: 15),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      course = value;
                                      print(
                                          course); // saving the selected value
                                    });
                                  },
                                  value:
                                      course, // displaying the selected value
                                ),
                              ),
                            ),
                          ),
                          _dropdownErrorCourse == null
                              ? SizedBox.shrink()
                              : Text(
                                  _dropdownErrorCourse ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: group,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Group',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Group';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                55, //gives the height of the dropdown button
                            width: MediaQuery.of(context)
                                .size
                                .width, //gives the width of the dropdown button
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Color(0xFFF2F2F2)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(
                                    0xFFF2F2F2), // background color for the dropdown items
                                buttonTheme: ButtonTheme.of(context).copyWith(
                                  alignedDropdown: true,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                // to hide the default underline of the dropdown button
                                child: DropdownButton<String>(
                                  iconEnabledColor: Color(
                                      0xFF595959), // icon color of the dropdown button
                                  items: [
                                    'Общежитие №. 1 (Деповская, 27)',
                                    'Общежитие №. 2 (проспект Ленина, 29)',
                                    'Общежитие №. 3 (проспект Ленина, 35)'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select your Hostel',
                                    style: TextStyle(
                                        color: Color(0xFF8B8B8B), fontSize: 15),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      hostel_no =
                                          value; // saving the selected value
                                    });
                                  },
                                  value:
                                      hostel_no, // displaying the selected value
                                ),
                              ),
                            ),
                          ),
                          _dropdownErrorHostel == null
                              ? SizedBox.shrink()
                              : Text(
                                  _dropdownErrorHostel ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: room_no,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                          labelText: 'Room No.',
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please a Enter Room No.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                55, //gives the height of the dropdown button
                            width: MediaQuery.of(context)
                                .size
                                .width, //gives the width of the dropdown button
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Color(0xFFF2F2F2)),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Color(
                                    0xFFF2F2F2), // background color for the dropdown items
                                buttonTheme: ButtonTheme.of(context).copyWith(
                                  alignedDropdown: true,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                // to hide the default underline of the dropdown button
                                child: DropdownButton<String>(
                                  iconEnabledColor: Color(
                                      0xFF595959), // icon color of the dropdown button
                                  items: [
                                    'admin',
                                    'second admin',
                                    'third-admin',
                                    'user'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select your position',
                                    style: TextStyle(
                                        color: Color(0xFF8B8B8B), fontSize: 15),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      position =
                                          value; // saving the selected value
                                      _dropdownErrorPosition = null;
                                    });
                                  },
                                  value:
                                      position, // displaying the selected value
                                ),
                              ),
                            ),
                          ),
                          _dropdownErrorPosition == null
                              ? SizedBox.shrink()
                              : Text(
                                  _dropdownErrorPosition ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          bool _isValid = _formkey.currentState.validate();
                          if (faculty == null) {
                            setState(() => _dropdownErrorFaculty =
                                "Please select Faculty");
                            _isValid = false;
                          }
                          if (course == null) {
                            setState(() =>
                                _dropdownErrorCourse = "Please select Course");
                            _isValid = false;
                          }
                          if (hostel_no == null) {
                            setState(() =>
                                _dropdownErrorHostel = "Please select Hostel");
                            _isValid = false;
                          }
                          if (position == null) {
                            setState(() => _dropdownErrorPosition =
                                "Please select Positon");
                            _isValid = false;
                          }

                          if (_isValid) {
                            _makePostRequest();
                            print('success');
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        textColor: Colors.white,
                        child: Text("Registration"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
