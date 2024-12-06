import 'package:flutter/material.dart';
import 'package:jobayaa/Models/jobaya.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class gridItem extends StatelessWidget {
  const gridItem({super.key, required this.jobaya});

  final job jobaya;

  @override
  Widget build(BuildContext context) {
    int textsize = 4;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      textsize = 9;
    }
    return Container(
      color: platformColors[jobaya.platform],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobaya.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "at ${jobaya.companyName}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 25.sp,
                      height: 25.sp,
                      child: Image.network(
                        platformIcons[jobaya.platform].toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / textsize,
                    child: Text(
                      jobaya.location,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
