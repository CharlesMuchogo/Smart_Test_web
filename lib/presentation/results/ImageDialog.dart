// image_dialog.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void showImageDialog(BuildContext context, String title, String imageUrl) {
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
      ],
    ),
    content: SizedBox(
      width: min(MediaQuery.of(context).size.width * 0.6, 500),
      height: min(MediaQuery.of(context).size.height * 0.6, 500),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, url, error) => const Center(
            child: Icon(
              Icons.image,
              size: 30,
            ),
          ),
        ),
      ),
    ),
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
