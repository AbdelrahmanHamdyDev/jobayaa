import 'package:flutter/material.dart';
import 'package:jobayaa/Models/jobaya.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobayaa/Screens/Edit.dart';
import 'package:url_launcher/url_launcher.dart';

class jobayaaInfo extends StatelessWidget {
  const jobayaaInfo({super.key, required this.jobaya});

  final job jobaya;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => editJobayaa(jobaya: jobaya),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobaya.name,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobaya.companyName,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                const Divider(),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: Image.network(
                          platformIcons[jobaya.platform].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    TextButton(
                      onPressed: () async {
                        try {
                          final Uri url = Uri.parse(jobaya.link);
                          bool launched = await launchUrl(url);
                        } catch (e) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Error"),
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Text(
                          jobaya.link,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                const Divider(),
                SizedBox(height: 10.h),
                Text(
                  jobaya.description,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
