import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PermissionStepCard extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String description;
  final String imageUrl;
  final String semanticLabel;

  const PermissionStepCard({
    Key? key,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      stepNumber.toString(),
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              description,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.dividerColor,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageWidget(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 25.h,
                  fit: BoxFit.cover,
                  semanticLabel: semanticLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
