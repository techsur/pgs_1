import 'package:flutter/material.dart';

class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? tag;
  final String? originalPrice;
  final String? discountedPrice;
  final String? buttonText;
  final Color? backgroundColor;
  final Color? textColor;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.tag,
    this.originalPrice,
    this.discountedPrice,
    this.buttonText,
    this.backgroundColor,
    this.textColor,
  });
}