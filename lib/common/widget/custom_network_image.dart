import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_project/common/const/colors.dart';

import '../imports/imports.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      filterQuality: FilterQuality.high,
      placeholder: (context, url) =>  Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Text('err'),
      fit: fit,
    );
  }
}
