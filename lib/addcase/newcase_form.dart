// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'files.dart';
import 'package:provider/provider.dart';

import 'app_datefield.dart';

import 'casenotes.dart';

// class newcase_form extends StatelessWidget {
//   const newcase_form({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CaseFormState>(
//       create: (_) => CaseFormState(),
//       child: _newcase_formContent(),
//     );
//   }
// }

final uid = FirebaseAuth.instance.currentUser!.uid;

class CaseFormState extends ChangeNotifier {
  String caseNo = '';
  String caseName = '';
  String hearingDate = '';
  String courtName = '';
  String partyName = '';
  String partyContactNo = '';
  String adverseParty = '';
  String advocateNumber = '';
  String casetype = '';
  String casenotes = '';
  List<String> team = [];
  String get textFieldValue => casenotes;

  void updateCasenotes(String value) {
    // print('value is $value');
    casenotes = value;
    // print('casenotes is $casenotes');
    notifyListeners();
  }
}

// ignore: camel_case_types
class newcase_form extends StatefulWidget {
  @override
  State<newcase_form> createState() => _newcase_formContentState();
}

// ignore: camel_case_types
class _newcase_formContentState extends State<newcase_form> {
  late User? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dropdownvalue = 'highcourt';
  String law = '';
  String dropdownvalue1 = 'upcoming';
  String uid = '';

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    initializeLawyerId();
    initializeCurrentUser();
  }

  void initializeLawyerId() async {
    String lawyerId = await fetchlawyerid();
    setState(() {
      law = lawyerId;
    });
  }

  void initializeCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
    uid = currentUser!.uid;
    print('uid:$uid');
  }

  void storeCaseData(CaseFormState caseData) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // add cases.
    caseData.team
        .clear(); // Clear the list if you want to ensure it only has one element
    caseData.team.add(law);
    caseData.courtName = dropdownvalue; // Add the 'law' value at the 0th index
    caseData.casetype = dropdownvalue1;

    // String casenotes1 = caseData.casenotes;
    // String casenotes2 = caseData.textFieldValue;
    // print('caseData CASE NOTES is $casenotes1');
    // print('caseData CASE NOTES2 is $casenotes2');

    try {
      firestore.collection(caseData.casetype).add({
        'caseNo': caseData.caseNo,
        'caseName': caseData.caseName,
        'hearingDate': caseData.hearingDate,
        'courtName': caseData.courtName,
        'partyName': caseData.partyName,
        'partyContactNo': caseData.partyContactNo,
        'adverseParty': caseData.adverseParty,
        'advocateNumber': caseData.advocateNumber,
        'casetype': caseData.casetype,
        'team': caseData.team,
        'casenotes': caseData.casenotes,
        'owner': uid
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Case added successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      // print(caseNameenc);
    } catch (e) {
      // print('firebase error $e');
    }
  }

  Future<String> fetchlawyerid() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();

    String law = userData['lawyerId'];
    return law;
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      await uploadFiles(files);
    }
  }

  Future<void> uploadFiles(List<File> files) async {
    for (File file in files) {
      String fileName = file.path.split('/').last;

      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('files').add({
        'fileName': fileName,
        'downloadUrl': downloadUrl,
        'createdAt': DateTime.now(),
      });
    }
    // print('File(s) uploaded successfully.');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File(s) uploaded successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController controller = TextEditingController();
    // print('controller text is $controller');

    // final String userId = currentUser?.uid ?? '';
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                transform: Matrix4.translationValues(170, 80, 0),
                child: const Text(
                  "JURID",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(185, 80, 0),
                child: const Text(
                  "ENT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(220, 160, 0),
                child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey.shade700),
                    child: const Text(
                      "Save as Draft",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
              ),
              Container(
                transform: Matrix4.translationValues(30, 80, 0),
                child: const Text(
                  "Add case",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(-140, 30, 0),
                      child: const Text(
                        "Case No",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .caseNo = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-130, 30, 0),
                      child: const Text(
                        "Case Name",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .caseName = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    AppTextFieldWithDatePicker(
                      title: "Hearing Date",
                      onChanged: (value) {
                        Provider.of<CaseFormState>(context, listen: false)
                            .hearingDate = value;
                      },
                      focusNode: FocusNode(),
                      onEditingComplete: () {},
                    ),
                    Container(
                      transform: Matrix4.translationValues(-125, 30, 0),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: DropdownButtonFormField<String>(
                        value: dropdownvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
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
                      transform: Matrix4.translationValues(-125, 30, 0),
                      child: const Text(
                        "Party Name",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .partyName = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-100, 30, 0),
                      child: const Text(
                        "Party Contact No",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .partyContactNo = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-100, 30, 0),
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .adverseParty = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-100, 30, 0),
                      child: const Text(
                        "Advocate Number",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: TextField(
                        onChanged: (value) {
                          Provider.of<CaseFormState>(context, listen: false)
                              .advocateNumber = value;
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.edit),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-125, 30, 0),
                      child: const Text(
                        "case Type",
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
                      padding:
                          const EdgeInsets.only(left: 28, right: 30, top: 50),
                      child: DropdownButtonFormField<String>(
                        value: dropdownvalue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue1 = newValue!;
                          });
                        },
                        items: <String>['upcoming', 'open', 'closed']
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
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  pickFiles();
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
                      'Upload Files',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/filedownload');
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
                      'Download Files',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const CustomeCaseNotes(
                      lawyerName: "John Doe",
                      time: "2023-06-17 10:00 AM",
                      notes: "",
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
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  final caseFormState =
                      Provider.of<CaseFormState>(context, listen: false);
                  storeCaseData(caseFormState);
                  // CaseFormState.team.add(law);
                  //  caseFormState.team.clear(); // Clear the list if you want to ensure it only has one element
                  //   caseFormState.team.add(law); // Add the 'law' value at the 0th index
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 100),
                  width: 174,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFEABE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'submit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
