import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wl_challenge/app/core/ui/styles/styles.dart';

class EmptyInfo extends StatelessWidget {
  const EmptyInfo({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/no_result.svg',
          height: 80,
        ),
        const SizedBox(height: 16),
        Text(
         text,
          style: AppTextStyles.medium.copyWith(
            fontSize: 16,
            color: AppColors.slateBlue,
          ),
        ),
      ],
    );
  }
}
