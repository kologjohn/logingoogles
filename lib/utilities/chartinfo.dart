import 'package:flutter/material.dart';
import 'package:goldcalcus/utilities/storage_info_card.dart';
import '../constants.dart';

Widget Chartinfo(){
  return Container(
    color: Colors.white10,
    padding: EdgeInsets.all(defaultPadding),
    decoration: const BoxDecoration(
      color: secondaryColor,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: defaultPadding),
       // Pie(context),
        StorageInfoCard(
          svgSrc: "assets/icons/Documents.svg",
          title: "Documents Files",
          amountOfFiles: "1.3GB",
          numOfFiles: 1328,
        ),
        StorageInfoCard(
          svgSrc: "assets/icons/media.svg",
          title: "Media Files",
          amountOfFiles: "15.3GB",
          numOfFiles: 1328,
        ),
        StorageInfoCard(
          svgSrc: "assets/icons/folder.svg",
          title: "Other Files",
          amountOfFiles: "1.3GB",
          numOfFiles: 1328,
        ),
        StorageInfoCard(
          svgSrc: "assets/icons/unknown.svg",
          title: "Unknown",
          amountOfFiles: "1.3GB",
          numOfFiles: 140,
        ),
      ],
    ),
  );
}
