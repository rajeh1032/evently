import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDateOrTime extends StatelessWidget {
  String IconImage;
  String eventText;
  String chooseText;

  VoidCallback onChoosedDateOrTime;

  EventDateOrTime({
    required this.IconImage,
    required this.eventText,
    required this.onChoosedDateOrTime,
    required this.chooseText,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        ImageIcon(AssetImage(IconImage)),
        SizedBox(
          width: width * 0.030,
        ),
        Text(
          eventText,
          style: AppStyles.bold16Grey
              .copyWith(color: Theme.of(context).hoverColor),
        ),
        Spacer(),
        TextButton(
            onPressed: () {
              onChoosedDateOrTime();
            },
            child: Text(
              chooseText,
              style: AppStyles.bold16Primary,
            )),
      ],
    );
  }
}
