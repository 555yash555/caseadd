import 'package:flutter/material.dart';
import 'casenotes.dart';
import 'package:intl/intl.dart';

class EditCaseDetailsPage extends StatefulWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;
  final String courtName;
  final String hearingDate;
  final String partyContactNo;
  final String adverseParty;
  final String adversePartyContactNo;
  final String adversePartyLawyer;
  final String caseType;
  final String casenotes;
  final Function(BuildContext, Map<String, dynamic>) onUpdate;

  const EditCaseDetailsPage({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.courtName,
    required this.hearingDate,
    required this.partyContactNo,
    required this.adverseParty,
    required this.adversePartyContactNo,
    required this.adversePartyLawyer,
    required this.onUpdate,
    required this.caseType,
    required this.casenotes,
  }) : super(key: key);

  @override
  _EditCaseDetailsPageState createState() => _EditCaseDetailsPageState();
}

class _EditCaseDetailsPageState extends State<EditCaseDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _courtNameController = TextEditingController();
  final TextEditingController _hearingDateController = TextEditingController();
  final TextEditingController _partyContactNoController =
      TextEditingController();
  final TextEditingController _adversePartyController = TextEditingController();
  final TextEditingController _adversePartyContactNoController =
      TextEditingController();
  final TextEditingController _adversePartyLawyerController =
      TextEditingController();
  String? _selectedCourt = '';

  @override
  void initState() {
    super.initState();
    _courtNameController.text = widget.courtName;
    _hearingDateController.text = widget.hearingDate;
    _partyContactNoController.text = widget.partyContactNo;
    _adversePartyController.text = widget.adverseParty;
    _adversePartyContactNoController.text = widget.adversePartyContactNo;
    _adversePartyLawyerController.text = widget.adversePartyLawyer;
  }

  @override
  void dispose() {
    _courtNameController.dispose();
    _hearingDateController.dispose();
    _partyContactNoController.dispose();
    _adversePartyController.dispose();
    _adversePartyContactNoController.dispose();
    _adversePartyLawyerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                transform: Matrix4.translationValues(-140, 10, 0),
                child: const Text(
                  "Court Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              // TextFormField(
              //   controller: _courtNameController,
              // ),
              //
              // Padding(
              //   padding: const EdgeInsets.only(left: 28, right: 30, top: 30),
              //   child: GestureDetector(
              //     onTap: () {
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             title: const Text('Select Court'),
              //             content: DropdownButtonFormField<String>(
              //               value: _selectedCourt,
              //               items: [
              //                 DropdownMenuItem(
              //                   value: 'Court 1',
              //                   child: const Text('Court 1'),
              //                 ),
              //                 DropdownMenuItem(
              //                   value: 'Court 2',
              //                   child: const Text('Court 2'),
              //                 ),
              //                 DropdownMenuItem(
              //                   value: 'Court 3',
              //                   child: const Text('Court 3'),
              //                 ),
              //                 // Add more DropdownMenuItem widgets for other court options
              //               ],
              //               onChanged: (String? value) {
              //                 setState(() {
              //                   _selectedCourt = value;
              //                 });
              //                 Navigator.of(context).pop(); // Close the dialog
              //               },
              //             ),
              //           );
              //         },
              //       );
              //     },
              //     child: TextFormField(
              //       controller: _courtNameController,
              //       decoration: InputDecoration(
              //         suffixIcon: const Icon(Icons.arrow_drop_down),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: const BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: const BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 25),
                child: DropdownButtonFormField<String>(
                  // value: dropdownvalue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _courtNameController.text = newValue!;
                    });
                  },
                  value: _courtNameController.text,
                  items: <String>['highcourt', 'newcourt', 'supremecourt']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(-120, 10, 0),
                child: const Text(
                  "Hearing Date",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 30),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.edit),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  controller: _hearingDateController,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData
                              .dark(), // Change the theme to dark for the date picker
                          child: child!,
                        );
                      },
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        // Format the selected date to exclude the time
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        _hearingDateController.text =
                            formattedDate; // Update the controller value with the formatted date
                      }
                    });
                  },
                ),
              ),

              Container(
                transform: Matrix4.translationValues(-80, 10, 0),
                child: const Text(
                  "Party Contact Number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 30),
                child: TextField(
                  controller: _partyContactNoController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              // TextFormField(
              //   controller: _partyContactNoController,
              //   decoration: InputDecoration(labelText: 'Party Contact No'),
              // ),
              Container(
                transform: Matrix4.translationValues(-120, 10, 0),
                child: const Text(
                  "Adverse Party",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 30),
                child: TextField(
                  controller: _adversePartyController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              // TextFormField(
              //   controller: _adversePartyController,
              //   decoration: InputDecoration(labelText: 'Adverse Party'),
              // ),
              Container(
                transform: Matrix4.translationValues(-50, 10, 0),
                child: const Text(
                  "Adverse Party Contact Number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 50),
                child: TextField(
                  controller: _adversePartyContactNoController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              // TextFormField(
              // controller: _adversePartyContactNoController,
              //   decoration: InputDecoration(labelText: 'Adverse Party Contact No'),
              // ),
              Container(
                transform: Matrix4.translationValues(-90, 10, 0),
                child: const Text(
                  "Adverse Party Lawyer",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 30, top: 50),
                child: TextField(
                  controller: _adversePartyLawyerController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.edit),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              // TextFormField(
              // controller: _adversePartyLawyerController,
              //   decoration: InputDecoration(labelText: 'Adverse Party Lawyer'),
              // ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print('save button');
                  if (_formKey.currentState!.validate()) {
                    final Map<String, dynamic> updatedData = {
                      'courtName': _courtNameController.text,
                      'hearingDate': _hearingDateController.text,
                      'partyContactNo': _partyContactNoController.text,
                      'adverseParty': _adversePartyController.text,
                      'adversePartyContactNo':
                          _adversePartyContactNoController.text,
                      'adversePartyLawyer': _adversePartyLawyerController.text,
                    };

                    // Call the onUpdate callback function with the updated data
                    widget.onUpdate(context, updatedData);
                  }
                },
                child: const Text('Save'),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomeCaseNotes(
                      lawyerName: "John Doe",
                      time: "2023-06-17 10:00 AM",
                      notes: widget.casenotes,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100),
                  width: 174,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFEABE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Add case notes',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
