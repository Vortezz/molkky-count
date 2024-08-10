import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';

class DropdownChildren {
  final String id;
  final Widget component;

  DropdownChildren({required this.id, required this.component});
}

class Dropdown extends StatefulWidget {
  const Dropdown({
    Key? key,
    required this.client,
    required this.children,
    required this.onSelected,
    this.value = "",
  }) : super(key: key);

  final Client client;
  final String value;
  final List<DropdownChildren> children;
  final Function(String?) onSelected;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late Client client;
  late List<DropdownChildren> children;
  late Function(String?) onSelected;

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    client = widget.client;
    children = widget.children;
    onSelected = widget.onSelected;

    if (widget.value != "") {
      selectedValue = widget.value;
    } else {
      selectedValue = children[0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 256,
      height: 56,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: client.getColor(
              ColorName.background,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                iconSize: 20,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
              ),
              style: TextStyle(
                color: client.getColor(ColorName.text1),
              ),
              isExpanded: true,
              isDense: true,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });

                onSelected(value);

                print("Selected value: $value");
              },
              value: selectedValue,
              items: children.map((DropdownChildren dropdownChildren) {
                return DropdownMenuItem<String>(
                  value: dropdownChildren.id,
                  child: dropdownChildren.component,
                );
              }).toList(),
              buttonStyleData: ButtonStyleData(
                width: 256,
                height: 56,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: client.getColor(
                          ColorName.text1,
                        ) ??
                        Colors.white,
                    width: 2,
                  ),
                  color: client.getColor(
                    ColorName.background,
                  ),
                ),
                elevation: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
