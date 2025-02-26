import 'package:practice_ryde/src/controllers/constants/linker.dart';
class RichTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  int maxLine;
   RichTextFormField({super.key,required this.controller,required this.hintText,this.maxLine=5});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.01),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        style: TextStyle(
          fontFamily: 'satoshi',
          color: Theme.of(context).colorScheme.secondary,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Appcolor.grey),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Appcolor.grey),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'satoshi',
              color: Colors.grey,
            )
        ),
      ),
    );
  }
}
