import 'package:flutter/services.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class CustomTextFormField extends StatefulWidget {

  String hintText;
  String msg;
  TextEditingController controller;
  IconData? suffixIcon;

   CustomTextFormField({super.key,
     required this.hintText,
     required this.controller,
     this.suffixIcon,
     this.msg='Enter Email',
   });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  bool hasError=false;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.01),
      child: TextFormField(
        controller: widget.controller,
        validator: (value){
          if(value!.isEmpty)
            {
              return widget.msg;
            }
          return null;
        },
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
            fontFamily: 'satoshi'
        ),
        decoration: InputDecoration(
            focusedBorder: hasError
                ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red, width: 2),
            )
                : OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Appcolor.yellow, width: 2),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Appcolor.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            border:InputBorder.none,
            hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey,fontFamily: 'satoshi'),
          suffixIcon:Icon(widget.suffixIcon,color: Colors.grey,size: 30,))
        ),
      );
  }
}
///==========================>>>Icon button feild
class TextFormFieldIconButton extends StatelessWidget {
   String hintText;
   TextEditingController controller;
   IconData iconData;
   VoidCallback onTap;
   TextFormFieldIconButton({super.key,
    required this.onTap,
     required this.hintText,
     required this.controller,
     required this.iconData,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * .02),
      child: TextFormField(
        controller: controller,
      style: TextStyle(
      color: Theme.of(context).colorScheme.secondary,
        fontFamily: 'satoshi'
      ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.yellow),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.grey),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey,fontFamily: 'satoshi'),
          suffixIcon: IconButton(onPressed: onTap, icon: Icon(iconData,color: Theme.of(context).colorScheme.tertiary,)),
        ),
      ),
    );
  }
}

///==========================>>>Password field

class PasswordTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  PasswordTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * .01),
      child: TextFormField(
        obscureText: isPassword,
        controller: widget.controller,
        validator: (value){
          if(value!.isEmpty)
          {
            return "Enter Password";
          }
          return null;
        },
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
            fontFamily: 'satoshi'
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.yellow),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey,fontFamily: 'satoshi'),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
            icon: Icon(
              isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

///==========================>>>OTP  field

class OtpTextformfield extends StatelessWidget {
  TextEditingController controller;
   OtpTextformfield({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Container(
      width: width*.15,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
            fontFamily: 'satoshi'
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.yellow),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.grey),
          ),
        ),
      ),
    );
  }
}
