

import 'package:practice_ryde/src/controllers/constants/linker.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Container(
      height: height*.05,
      width:  width *.1,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.background,
      ),
      child: IconButton(onPressed: (){
        Navigator.pop(context);
      },
          icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.secondary,)),
    );
  }
}
