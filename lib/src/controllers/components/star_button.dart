import 'package:practice_ryde/src/controllers/constants/linker.dart';

class StarButton extends StatelessWidget {
  Color color;
  VoidCallback onTap;
   StarButton({super.key,required this.onTap,this.color=Colors.grey});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return  IconButton(
      onPressed: onTap,
      icon: Icon(Icons.star,size: width*.12,color: color),
    );
  }
}
