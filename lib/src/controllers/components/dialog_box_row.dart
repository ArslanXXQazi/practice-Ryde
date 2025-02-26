import 'package:practice_ryde/src/controllers/constants/linker.dart';

class DialogBoxRow extends StatelessWidget {
  String image;
  String text;
  VoidCallback onTap;
  DialogBoxRow({super.key,
    required this.onTap,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.01),
        child: Row(children: [
          ImageIcon(AssetImage(image),size: width*.07,color: Theme.of(context).colorScheme.primary,),
          SizedBox(width: width*.02,),
          CustomText(text: text,fontSize: 16,color: Theme.of(context).colorScheme.secondary,)
        ],),
      ),
    );
  }
}
