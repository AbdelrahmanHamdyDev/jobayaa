import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobayaa/Models/jobaya.dart';
import 'package:jobayaa/SQLite/database.dart';
import 'package:jobayaa/Screens/Home.dart';

final SqlLiteDB sqlDb = SqlLiteDB();

class editJobayaa extends StatefulWidget {
  const editJobayaa({super.key, required this.jobaya});

  final job jobaya;

  @override
  State<editJobayaa> createState() => _editJobayaaState();
}

class _editJobayaaState extends State<editJobayaa> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _companyNameController;

  late TextEditingController _linkController;

  late TextEditingController _descriptionController;

  late Platform? _selectedPlatform;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.jobaya.name);
    _companyNameController =
        TextEditingController(text: widget.jobaya.companyName);
    _linkController = TextEditingController(text: widget.jobaya.link);
    _descriptionController =
        TextEditingController(text: widget.jobaya.description);
    _selectedPlatform = widget.jobaya.platform;
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String companyName = _companyNameController.text;
      final String link = _linkController.text;
      final Platform platform = _selectedPlatform!;
      final String description = _descriptionController.text;

      job UpdatedJob = job(
        id: widget.jobaya.id,
        name: name,
        link: link,
        companyName: companyName,
        platform: platform,
        description: description,
      );

      await sqlDb.updateJob(UpdatedJob);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _companyNameController,
                      decoration: const InputDecoration(
                        labelText: 'Company Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<Platform>(
                            value: _selectedPlatform,
                            decoration: const InputDecoration(
                              labelText: 'Platform',
                              border: OutlineInputBorder(),
                            ),
                            items: Platform.values.map(
                              (platform) {
                                return DropdownMenuItem(
                                  value: platform,
                                  child: Text(platform.name),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedPlatform = value;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextFormField(
                            controller: _linkController,
                            decoration: const InputDecoration(
                              labelText: 'Link',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),
            // Submit Button
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
