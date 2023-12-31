// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juridentt/features/teams/viewaccess.dart';
import 'casenotes.dart';
import 'editcase.dart';
import 'package:google_fonts/google_fonts.dart';

class CaseDetailsPage extends StatefulWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;

  final String caseType;

  const CaseDetailsPage({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.caseType,
  }) : super(key: key);

  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  Map<String, dynamic>? caseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCaseDetails();
  }

  void fetchCaseDetails() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(widget.caseType)
          .where('caseNo', isEqualTo: widget.caseNumber)
          .where('caseName', isEqualTo: widget.caseName)
          .where('partyName', isEqualTo: widget.partyName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

        setState(() {
          caseData = documentSnapshot.data();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Failed to fetch case details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateCaseDetails(
      BuildContext context, Map<String, dynamic> updatedData) async {
    try {
      print('update');
      print(updatedData);
      final CollectionReference casesCollection =
          FirebaseFirestore.instance.collection(widget.caseType);

      final QuerySnapshot<Object?> snapshot = await casesCollection
          .where('caseNo', isEqualTo: widget.caseNumber)
          // .where('casetype', isEqualTo: widget.caseType)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

        // Update the fields with the updatedData
        final Map<String, dynamic> currentData = documentSnapshot.data()!;
        final Map<String, dynamic> newData = {
          ...currentData,
          ...updatedData,
        };

        await documentSnapshot.reference.update(newData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Case details updated successfully')),
        );

        // Refresh case details
        fetchCaseDetails();
      }
    } catch (error) {
      print('error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16, left: 30),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : caseData != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(
                                  context); // Navigate back when the back icon is pressed
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Case Details',
                            style: GoogleFonts.poppins(
                                fontSize: 28,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Case Number:  ${widget.caseNumber}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Case Name:  ${widget.caseName}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Party Name:  ${widget.partyName}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Court Name: ${caseData!['courtName']}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: const Color(0XFF08023A),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Hearing Date:  ${caseData!['hearingDate']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Party Contact No:  ${caseData!['partyContactNo']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Adverse Party:  ${caseData!['adverseParty']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Adverse Party\nContact No:   ${caseData!['adversePartyContactNo']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Adverse Party\nLawyer:   ${caseData!['adversePartyLawyer']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: const Color(0XFF08023A),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (!isLoading && caseData != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditCaseDetailsPage(
                                          caseNumber: widget.caseNumber,
                                          caseName: widget.caseName,
                                          partyName: widget.partyName,
                                          courtName:
                                              caseData!['courtName'] ?? '',
                                          hearingDate:
                                              caseData!['hearingDate'] ?? '',
                                          partyContactNo:
                                              caseData!['partyContactNo'] ?? '',
                                          adverseParty:
                                              caseData!['adverseParty'] ?? '',
                                          adversePartyContactNo: caseData![
                                                  'adversePartyContactNo'] ??
                                              '',
                                          adversePartyLawyer:
                                              caseData!['adversePartyLawyer'] ??
                                                  '',
                                          onUpdate: updateCaseDetails,
                                          caseType: widget.caseType,
                                          casenotes:
                                              caseData!['casenotes'] ?? '',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 171,
                                  height: 66,
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFD9D9D9),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // changes the position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Edit Case\nDetails',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0XFF08023A)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (!isLoading && caseData != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const TeamsPage(),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 171,
                                  height: 66,
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFD9D9D9),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0,
                                            3), // changes the position of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Allow\nAccess',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0XFF08023A)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (widget.caseType ==
                              'open') // Only show the button if caseType is "open"
                            InkWell(
                              // onTap: () async {
                              //   if (!isLoading && caseData != null) {
                              //     try {
                              //       // Retrieve the case number
                              //       final String caseNumber =
                              //           caseData!['caseNo'];

                              //       // Create a reference to the Firestore instance
                              //       final FirebaseFirestore firestore =
                              //           FirebaseFirestore.instance;

                              //       // Create a reference to the "open" collection
                              //       final CollectionReference
                              //           openCollectionRef =
                              //           firestore.collection(widget.caseType);

                              //       // Query the collection to find the document with the matching case number
                              //       final QuerySnapshot<Object?> snapshot =
                              //           await openCollectionRef
                              //               .where('caseNo',
                              //                   isEqualTo: caseNumber)
                              //               .get();

                              //       if (snapshot.docs.isNotEmpty) {
                              //         final DocumentSnapshot<
                              //                 Map<String, dynamic>>
                              //             documentSnapshot = snapshot.docs.first
                              //                 as DocumentSnapshot<
                              //                     Map<String, dynamic>>;

                              //         // Retrieve the document data
                              //         final Map<String, dynamic> data =
                              //             documentSnapshot.data()!;

                              //         // Create a reference to the "closed" collection
                              //         final CollectionReference
                              //             closedCollectionRef =
                              //             firestore.collection('closed');

                              //         // Add the document data to the "closed" collection with the same document ID
                              //         await closedCollectionRef
                              //             .doc(documentSnapshot.id)
                              //             .set(data);

                              //         // Delete the document from the "open" collection
                              //         await documentSnapshot.reference.delete();

                              //         // Display a success message
                              //         ScaffoldMessenger.of(context)
                              //             .showSnackBar(
                              //           const SnackBar(
                              //               content:
                              //                   Text('Record moved to closed')),
                              //         );
                              //       } else {
                              //         ScaffoldMessenger.of(context)
                              //             .showSnackBar(
                              //           const SnackBar(
                              //               content: Text('Record not found')),
                              //         );
                              //       }
                              //     } catch (error) {
                              //       print('Failed to move record: $error');
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         const SnackBar(
                              //             content:
                              //                 Text('Failed to move record')),
                              //       );
                              //     }
                              //   }
                              // },
                              onTap: () async {
                                if (!isLoading && caseData != null) {
                                  try {
                                    // Retrieve the case number
                                    final String caseNumber =
                                        caseData!['caseNo'];

                                    // Create a reference to the Firestore instance
                                    final FirebaseFirestore firestore =
                                        FirebaseFirestore.instance;

                                    // Create a reference to the "open" collection
                                    final CollectionReference
                                        openCollectionRef =
                                        firestore.collection(widget.caseType);

                                    // Query the collection to find the document with the matching case number
                                    final QuerySnapshot<Object?> snapshot =
                                        await openCollectionRef
                                            .where('caseNo',
                                                isEqualTo: caseNumber)
                                            .get();

                                    if (snapshot.docs.isNotEmpty) {
                                      final DocumentSnapshot<
                                              Map<String, dynamic>>
                                          documentSnapshot = snapshot.docs.first
                                              as DocumentSnapshot<
                                                  Map<String, dynamic>>;

                                      // Retrieve the document data
                                      final Map<String, dynamic> data =
                                          documentSnapshot.data()!;
                                      // Create a reference to the "closed" collection
                                      final CollectionReference
                                          closedCollectionRef =
                                          firestore.collection('closed');

                                      // Update the caseType to "closed" in the document data
                                      data['caseType'] = 'closed';

                                      // Add the document data to the "closed" collection with the same document ID
                                      await closedCollectionRef
                                          .doc(documentSnapshot.id)
                                          .set(data);

                                      // Delete the document from the "open" collection
                                      await documentSnapshot.reference.delete();

                                      // Display a success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Record moved to closed')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Record not found')),
                                      );
                                    }
                                  } catch (error) {
                                    print('Failed to move record: $error');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Failed to move record')),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: 360,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFD9D9D9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0,
                                          3), // changes the position of the shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Close case',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0XFF08023A),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => CustomeCaseNotes(
                                  lawyerName: "John Doe",
                                  time: "2023-06-17 10:00 AM",
                                  notes: caseData!['casenotes'] ?? '',
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
                      )
                    : const Center(child: Text('Failed to fetch case details')),
          ),
        );
      },
    );
  }
}
