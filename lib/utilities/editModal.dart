import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
class EditModal extends StatelessWidget {
  const EditModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          //ModalBottomSheet(expanded: true, child: null,);
        }, child: Text("Bottom"))
      ],
    );
  }
}
