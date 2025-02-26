import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ProfileContainer extends StatelessWidget {
  String image;
   ProfileContainer({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return CircleAvatar(
      radius: width*.12,
      backgroundColor:Theme.of(context).colorScheme.background,
      backgroundImage: AssetImage(image),
    );
  }
}
