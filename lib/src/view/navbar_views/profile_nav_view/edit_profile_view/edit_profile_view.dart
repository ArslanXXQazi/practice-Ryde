import 'package:practice_ryde/src/controllers/components/profile_container.dart';
import 'package:practice_ryde/src/controllers/components/rich_text_form_field.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';


class EditProfileView extends StatefulWidget {
  String image;
  VoidCallback ontap;
   EditProfileView({super.key,required this.image,required this.ontap});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:Theme.of(context).colorScheme.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldText(text: 'Edit Profile',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
            TextButton(
              onPressed: (){Navigator.pop(context);},
              child:  BoldText(text: 'Save',fontSize: 18,color: Colors.blue),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(
                child:Stack(
                  children: [
                    ProfileContainer(image: widget.image),
                    Padding(
                      padding:  EdgeInsets.only(left: width*.18,top: height*.065),
                      child: GestureDetector(
                        onTap: (){},
                        child: CircleAvatar(
                          radius: width*.04,
                          backgroundColor: Appcolor.yellow,
                          child: Center(child: ImageIcon(AssetImage(Appimages.edit))),
                        ),
                      ),
                    )
                  ],
                )
            ),
            CustomText(text: 'Your Name',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
            CustomTextFormField(hintText: 'John Doe', controller: nameController),
            CustomText(text: 'Email',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
            CustomTextFormField(hintText: 'johndoe@gmail.com', controller: emailController),
            CustomText(text: 'Phone Number',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
            CustomTextFormField(hintText: '0348 3424529', controller: phoneController),
            CustomText(text: 'Addess',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
            RichTextFormField(
                controller: addressController,
                hintText: 'House no. 123, Street no. 456, Sector 7, Islamabad',
                maxLine: 2,
            )
          ],),
        ),
      ),
    );
  }
}



