import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp_get_storage/utils/themes.dart';

class TextInputWidget extends StatelessWidget {
  final String text;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const TextInputWidget({
    Key? key,
    required this.text,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 15),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // readOnly to make a container clickable not writeable
                    readOnly: widget == null?false:true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
