import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';


import 'caseswidget.dart';


class CasePage extends StatefulWidget {
  const CasePage({Key? key}) : super(key: key);

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  late String lawyerId;
  List<Map<String, dynamic>> openCases = [];
  List<Map<String, dynamic>> openCasesLists = [];
  List<Map<String, dynamic>> closedCases = [];
  List<Map<String, dynamic>> closedCasesLists = [];
  List<Map<String, dynamic>> upcomingCases = [];
  List<Map<String, dynamic>> upcomingCasesLists = [];
  bool isListViewVisible = false;
  int selectedCaseIndex = -1;
  
  User? currentUser;
    String uid='';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchLawyerId();
    openCasesList();
    closedCasesList();
    upcomingCasesList();
    initializeCurrentUser();
  }
    void initializeCurrentUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
    uid=currentUser!.uid;
   // print('uid:$uid');
  }


  Future<void> fetchLawyerId() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc =
        FirebaseFirestore.instance.collection('lawyers').doc(user!.uid);
    final userData = await userDoc.get();
    setState(() {
      lawyerId = userData['lawyerId'];
    });
  }

  void openCasesList() 
  async
  {
     final trace = FirebasePerformance.instance.newTrace('openCasesListTrace');
    await trace.start();
    print(uid);
    FirebaseFirestore.instance
        .collection('open')
        //.where('team', arrayContains: uid)
        .where('owner', isEqualTo: uid)
                .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> openCases = snapshot.docs
          .map((doc) => doc.data())
          .toList();
      setState(() {
        openCasesLists = openCases;
      });
    });
    await trace.stop();
  }

  void closedCasesList()async {
    
     final trace = FirebasePerformance.instance.newTrace('closedlisttrace');
      await trace.start();
  print("Inside closedCasesList"); // Add this line to indicate the method is being called
  FirebaseFirestore.instance
      .collection('closed')
      .where('owner', isEqualTo: uid)
      .snapshots()
      .listen((snapshot) {
    print("Closed Cases Snapshot: $snapshot"); // Add this line to check the snapshot value
    List<Map<String, dynamic>> closedCases = snapshot.docs
        .map((doc) => doc.data())
        .toList();
    print("Closed Cases: $closedCases"); // Add this line to check the closed cases data
    setState(() {
      closedCasesLists = closedCases;
    });
  });
   await trace.stop();
}


  void upcomingCasesList() async{
    final trace = FirebasePerformance.instance.newTrace('upcominglisttrace');
      await trace.start();
    FirebaseFirestore.instance
        .collection('upcoming')
       // .where('team', arrayContains: lawyerId)
        .where('owner', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> upcomingCases = snapshot.docs
          .map((doc) => doc.data())
          .toList();
      setState(() {
        upcomingCasesLists = upcomingCases;
      });
    });
     await trace.stop();
  }

  void handleCaseTap(int index) {
    setState(() {
      if (selectedCaseIndex == index) {
        selectedCaseIndex = -1;
        isListViewVisible = false;
      } else {
        selectedCaseIndex = index;
        isListViewVisible = true;
      }
    });
  }

  void handleCaseTapCancel() {
    setState(() {
      selectedCaseIndex = -1;
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 85),
        child: Column(
          children: [
            const Text(
              "JURIDENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => handleCaseTap(0),
                  onTapCancel: handleCaseTapCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedCaseIndex == 0
                          ? const Color(0xffC99F4A)
                          : const Color(0xff050125),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: screenWidth > 380 ? 120 : 100,
                    height: screenHeight > 615 ? 120 : 100,
                    child: Center(
                      child: Text(
                        '${openCasesLists.length} \nOpen\ncases',
                        style: TextStyle(
                          fontSize: 20,
                          color: selectedCaseIndex == 0
                              ? Colors.black
                              : const Color(0xffC99F4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => handleCaseTap(1),
                  onTapCancel: handleCaseTapCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedCaseIndex == 1
                          ? const Color(0xffC99F4A)
                          : const Color(0xff050125),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: screenWidth > 380 ? 120 :100,
                    height: screenHeight > 615 ? 120 :100,
                    child: Center(
                      child: Text(
                        '${closedCasesLists.length} \nClosed\ncases',
                        style: TextStyle(
                          fontSize: 20,
                          color: selectedCaseIndex == 1
                              ? Colors.black
                              : const Color(0xffC99F4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => handleCaseTap(2),
                  onTapCancel: handleCaseTapCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedCaseIndex == 2
                          ? const Color(0xffC99F4A)
                          : const Color(0xff050125),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: screenWidth > 380 ? 120 :100,
                    height: screenHeight > 615 ? 120 :100,
                    child: Center(
                      child: Text(
                        '${upcomingCasesLists.length} \nUpcoming\ncases',
                        style: TextStyle(
                          fontSize: 20,
                          color: selectedCaseIndex == 2
                              ? Colors.black
                              : const Color(0xffC99F4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
     if (isListViewVisible && selectedCaseIndex == 0)
  Expanded(
    child: Container(
      width: screenWidth > 380 ? 380 : screenWidth,
      height: screenHeight > 615 ? 615 : screenHeight,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: openCasesLists.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> caseData = openCasesLists[index];
              final caseName = caseData['caseName'] ?? '';
              final partyName = caseData['partyName'] ?? '';
              final caseNumber = caseData['caseNo'] ?? '';
              return LandingItemWidget(
                caseName: caseName,
                partyName: partyName,
                caseNumber: caseNumber,
                caseType: 'open',
              );
            },
          ),
        ),
      ),
    ),
  ),

if (isListViewVisible && selectedCaseIndex == 1)
  Expanded(
    child: Container(
      width: screenWidth > 380 ? 380 : screenWidth,
      height: screenHeight > 615 ? 615 : screenHeight,
      child: ListView.builder(
        itemCount: closedCasesLists.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> caseData = closedCasesLists[index];
          final caseName = caseData['caseName'] ?? '';
          final partyName = caseData['partyName'] ?? '';
          final caseNumber = caseData['caseNo'] ?? '';
          return LandingItemWidget(
            caseName: caseName,
            partyName: partyName,
            caseNumber: caseNumber,
            caseType: 'closed',
          );
        },
      ),
    ),
  ),
if (isListViewVisible && selectedCaseIndex == 2)
  Expanded(
    child: Container(
      width: screenWidth > 380 ? 380 : screenWidth,
      height: screenHeight > 615 ? 615 : screenHeight,
      child: ListView.builder(
        itemCount: upcomingCasesLists.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> caseData = upcomingCasesLists[index];
          final caseName = caseData['caseName'] ?? '';
          final partyName = caseData['partyName'] ?? '';
          final caseNumber = caseData['caseNo'] ?? '';
          return LandingItemWidget(
            caseName: caseName,
            partyName: partyName,
            caseNumber: caseNumber,
            caseType: 'upcoming',
          );
        },
      ),
    ),
  ),
          ],
        ),
      ),
    );
  }
}
