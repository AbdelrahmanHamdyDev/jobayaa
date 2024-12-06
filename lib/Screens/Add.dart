import 'package:flutter/material.dart';
import 'package:jobayaa/Models/jobaya.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobayaa/SQLite/database.dart';

final SqlLiteDB sqlDb = SqlLiteDB();

class newJobaya extends StatefulWidget {
  @override
  State<newJobaya> createState() => _newJobayaState();
}

class _newJobayaState extends State<newJobaya> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _linkController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  Platform? _selectedPlatform;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String companyName = _companyNameController.text;
      final String link = _linkController.text;
      final Platform platform = _selectedPlatform!;
      final String description = _descriptionController.text;

      job newJob = job(
        id: null,
        name: name,
        link: link,
        companyName: companyName,
        platform: platform,
        description: description,
      );

      await sqlDb.insertJob(newJob);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Company Name Field
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a company name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Link Field
                TextFormField(
                  controller: _linkController,
                  decoration: const InputDecoration(
                    labelText: 'Link',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a link';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Platform Dropdown
                DropdownButtonFormField<Platform>(
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a platform';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
