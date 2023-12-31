import 'package:flutter/material.dart';
import 'newcase_form.dart';
import 'provider.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class CustomeCaseNotes extends StatefulWidget {
  final String time;
  final String lawyerName;
  final String notes;

  const CustomeCaseNotes({
    Key? key,
    required this.lawyerName,
    required this.time,
    required this.notes,
  }) : super(key: key);

  @override
  State<CustomeCaseNotes> createState() => _CustomeCaseNotesState();
}

class _CustomeCaseNotesState extends State<CustomeCaseNotes> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeChanger>(context);

    return TextButton(
      onPressed: () {
        showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          backgroundColor: themeProvider.isDarkMode
              ? Colors.white
              : caseNotesBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          context: context,
          builder: ((context) {
            return Wrap(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.014),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.311,
                          right: screenWidth * 0.311,
                        ),
                        child: Divider(
                          color: darkModeButtonColor,
                          thickness: 3,
                          height: 7,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          top: screenHeight * 0.024,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Case Notes",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.3),
                            Container(
                              height: screenHeight * 0.04,
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode
                                    ? backColor
                                    : darkModeButtonColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Save as Draft",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.039),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.07),
                        child: Text(
                          "${widget.lawyerName}'s Case Notes",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          top: screenHeight * 0.024,
                        ),
                        child: Text(
                          widget.time,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            initialValue: widget.notes,
                            onChanged: (value) {
                              final textFieldValueProvider =
                                  Provider.of<CaseFormState>(context,
                                      listen: false);
                              textFieldValueProvider.updateCasenotes(value);
                            },
                            // controller: controllerInput,
                            maxLines: 18,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                            decoration: InputDecoration(
                              fillColor: formFillColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Add your case notes",
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.016),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.07,
                          right: screenWidth * 0.07,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: formFillColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "B",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "/",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "U",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.067),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  child: const Text(""),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.067),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.menu_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
      child: const Text("Show case notes"),
    );
  }
}
