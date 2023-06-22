import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AppTextFieldWithDatePicker extends StatefulWidget {
  final String title;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final Function() onEditingComplete;

  const AppTextFieldWithDatePicker({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.focusNode,
    required this.onEditingComplete,
  }) : super(key: key);

  @override
  State<AppTextFieldWithDatePicker> createState() =>
      _AppTextFieldWithDatePickerState();
}

class _AppTextFieldWithDatePickerState
    extends State<AppTextFieldWithDatePicker> {
  late TextEditingController _textEditingController;
  late DateTime _selectedDate;
  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _selectedDate = DateTime.now();
    _dateFormat = DateFormat('dd/MM/yyyy');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _textEditingController.text = _dateFormat.format(picked);
        widget.onChanged(_dateFormat.format(picked));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:23,left:16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
            child: Text(
              widget.title,
              style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                        ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 65,
              
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: widget.onChanged,
                      onEditingComplete: widget.onEditingComplete,
                      focusNode: widget.focusNode,
                      controller: _textEditingController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\/\d+\/\d+$')),
                      ],
                      enabled: false, // Set the TextFormField as read-only
                      decoration: const InputDecoration(
                        hintText: 'Choose Date',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
