import 'dart:io';

import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/imports/imports.dart';
import 'package:driver_project/common/widget/custom_network_image.dart';

class ProfileCar extends StatelessWidget {
  const ProfileCar({
    super.key,
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    printG(imagePath);

    final isLocal = imagePath!.contains('com.example.driver_project');
    if (isLocal) {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
      );
    } else {
      return CustomNetworkImage(
        imageUrl: '${AppUrl.baseUrl}/${imagePath!}',
        fit: BoxFit.cover,
      );
    }
  }
}
