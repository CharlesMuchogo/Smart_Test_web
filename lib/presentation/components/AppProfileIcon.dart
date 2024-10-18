import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppProfileIcon extends StatelessWidget {
  const AppProfileIcon( {required this.imageUrl, super.key});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    log("Image url $imageUrl");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: 50,
        decoration:  const BoxDecoration(
          color: Color.fromRGBO(243, 244, 248, 100) ,
          shape: BoxShape.circle
        ),
        child:  AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
