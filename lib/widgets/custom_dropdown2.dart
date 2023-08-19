import 'package:ams_count/config/app_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton2 extends StatelessWidget {
  const CustomDropdownButton2(
      {super.key,
      this.items,
      this.selectedValue,
      this.onChanged,
      this.labelText,
      this.hintText,
      this.focusNode});

  final List<DropdownMenuItem<String>>? items;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      // isExpanded: true,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: colorPrimary),
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        // Add more decoration..
      ),
      // hint: const Text(
      //   'Select Status',
      //   style: TextStyle(
      //       fontSize: 14, color: colorPrimary, fontWeight: FontWeight.bold),
      // ),
      items: items,
      // validator: (value) {
      //   if (value == null) {
      //     return 'Please select Status.';
      //   }
      //   return null;
      // },
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
