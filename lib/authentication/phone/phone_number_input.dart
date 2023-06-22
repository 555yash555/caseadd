// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:juridentt/constants.dart';
import 'package:juridentt/resources/auth.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({Key? key}) : super(key: key);

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  TextEditingController phoneNumber = TextEditingController(text: '8438006590');

  bool keepLoggedIn = true;

  final FocusNode _focusNode1 = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _focusNode1.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  void _loseFocus() {
    _focusNode1.unfocus();
  }

  void updatePhoneNumber() async {
    String res = await Auth().updatePhoneNumber(
      phoneNumber: phoneNumber.text,
    );
    if (res == 'success') {
      Navigator.pushNamed(context, '/homescreen');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              res,
              textAlign: TextAlign.center,
              style: Constants.satoshiLightBlackNormal22,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: Constants.lightBlackBold,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(201, 159, 74, 0.54),
        backgroundColor: Constants.orange,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              const Image(
                image: AssetImage(
                  'assets/images/ellipse.png',
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Welcome to Jurident",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: Constants.satoshiYellowNormal22),
                      Container(
                        width: 358,
                        margin: const EdgeInsets.only(top: 17),
                        child: Text(
                            "Are you ready to become a legal eagle? Login to the app and spread your wings in the courtroom.",
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            style: Constants.satoshiBlackNormal18),
                      ),
                      Container(
                        height: 464,
                        width: 440,
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.only(
                            left: 29, right: 20, bottom: 31),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Constants.white,
                          border: Border.all(
                            color: Constants.black33,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.black4c,
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 250),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Log In",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: Constants
                                              .satoshiTransparentNormal22Underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 28, bottom: 2),
                                      child: Text(
                                        "Sign Up",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:
                                            Constants.satoshiLightBlackNormal22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -120.0, 0.0),
                              child: Text(
                                "Enter your phone number:",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: Constants.satoshiBlackNormal18,
                              ),
                            ),
                            Container(
                              transform:
                                  Matrix4.translationValues(0.0, -100.0, 0.0),
                              child: TextFormField(
                                focusNode: _focusNode1,
                                onEditingComplete: _loseFocus,
                                controller: phoneNumber,
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  contentPadding: const EdgeInsets.only(
                                    left: 10,
                                    top: 16,
                                    right: 7,
                                    bottom: 16,
                                  ),
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      top: 16,
                                      right: 7,
                                      bottom: 16,
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: Constants.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                      color: Constants.black,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                      color: Constants.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }

                                  // Regular expression for 10-digit number validation
                                  final numberRegex = RegExp(r'^\d{10}$');

                                  if (!numberRegex.hasMatch(value)) {
                                    return 'Please enter a valid 10-digit number';
                                  }

                                  return null; // Return null to indicate no validation errors
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updatePhoneNumber();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.lightblack,
                                minimumSize: const Size(320, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Submit",
                                style: Constants.satoshiWhite18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
