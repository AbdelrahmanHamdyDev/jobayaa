import 'package:flutter/material.dart';
import 'package:jobayaa/SQLite/database.dart';
import 'package:jobayaa/Screens/Add.dart';
import 'package:jobayaa/Screens/Info.dart';
import 'package:jobayaa/Widgets/grid_items.dart';
import 'package:jobayaa/Models/jobaya.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final SqlLiteDB sqlDb = SqlLiteDB();

class jobayaaHome extends StatefulWidget {
  @override
  State<jobayaaHome> createState() => _jobayaaHomeState();
}

class _jobayaaHomeState extends State<jobayaaHome> {
  @override
  void dispose() {
    super.dispose();
    sqlDb.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sqlDb.getDb();

    int _widthCount = 2;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      _widthCount = 3;
    }

    return Scaffold(
      floatingActionButton: IconButton.filled(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => newJobaya(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        iconSize: 25.sp,
      ),
      body: StreamBuilder(
        stream: sqlDb.jobStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.isEmpty || !snapshot.hasData) {
            return Center(
              child: Text(
                "No jobs available \nTry add some ....",
                style: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
            );
          }
          List<job> jobs = snapshot.data!;
          return GridView.builder(
            itemCount: jobs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _widthCount,
              mainAxisExtent: 150.sp,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => jobayaaInfo(
                        jobaya: jobs[index],
                      ),
                    ),
                  );
                },
                child: Dismissible(
                  key: ValueKey(jobs[index].id),
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    sqlDb.deleteJob(jobs[index]);
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Job Removed."),
                        action: SnackBarAction(
                            label: "Undo",
                            onPressed: () async {
                              await sqlDb.insertJob(jobs[index]);
                            }),
                      ),
                    );
                  },
                  child: gridItem(jobaya: jobs[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
