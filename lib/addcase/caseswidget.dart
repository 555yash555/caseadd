// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class LandingItemWidget extends StatelessWidget {
//   const LandingItemWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 14,
//         bottom: 14,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.yellow,
//         border: Border.all(
//           color: Colors.black,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             height: 111,
//             width: 118,
//             margin: const EdgeInsets.only(
//               bottom: 1,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               bottom: 1,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 249,
//                   margin: const EdgeInsets.only(
//                     right: 1,
//                   ),
//                   padding: const EdgeInsets.only(
//                     left: 8,
//                     top: 16,
//                     right: 8,
//                     bottom: 16,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 1,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Case Number:  ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "23-FA-12345",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 10,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Case",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: " ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Name:",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Divorce Case",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 11,
//                           bottom: 3,
//                         ),
//                         child: RichText(
//                           text: const TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Party Name:",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: " ",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Abhinav",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15,
//                                   fontFamily: 'Satoshi',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'casedetails.dart';

class LandingItemWidget extends StatelessWidget {
  final String caseNumber;
  final String caseName;
  final String partyName;
  final String caseType;

  const LandingItemWidget({
    Key? key,
    required this.caseNumber,
    required this.caseName,
    required this.partyName,
    required this.caseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CaseDetailsPage(
              caseType: caseType,
              caseNumber: caseNumber,
              caseName: caseName,
              partyName: partyName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
       
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffC99F4A),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 111,
              width: 109
              
              
              ,
              margin: const EdgeInsets.only(
                bottom: 1,
                left: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 1,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.55,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 1,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Case Number:  ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: caseNumber,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Case",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Name:",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: caseName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 11,
                            bottom: 3,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Party Name:",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: partyName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
