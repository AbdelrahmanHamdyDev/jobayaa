import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobayaa/Models/jobaya.dart';
import 'package:jobayaa/SQLite/database.dart';

final SqlLiteDB sqlDb = SqlLiteDB();

class jobayaaInput extends StatefulWidget {
  const jobayaaInput({super.key, this.jobaya});

  final job? jobaya;

  @override
  State<jobayaaInput> createState() => _jobayaaInputState();
}

class _jobayaaInputState extends State<jobayaaInput> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _companyNameController = TextEditingController();

  TextEditingController _linkController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _locationController = TextEditingController();

  Platform? _selectedPlatform;

  @override
  void initState() {
    if (widget.jobaya != null) {
      _nameController = TextEditingController(text: widget.jobaya!.name);
      _companyNameController =
          TextEditingController(text: widget.jobaya!.companyName);
      _linkController = TextEditingController(text: widget.jobaya!.link);
      _descriptionController =
          TextEditingController(text: widget.jobaya!.description);
      _locationController =
          TextEditingController(text: widget.jobaya!.location);
      _selectedPlatform = widget.jobaya!.platform;
    }
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String companyName = _companyNameController.text;
      final String link = _linkController.text;
      final Platform platform = _selectedPlatform!;
      final String description = _descriptionController.text;
      final String location = _locationController.text;

      final theId;

      if (widget.jobaya != null) {
        theId = widget.jobaya!.id;
      } else {
        theId = null;
      }

      job JobTemplete = job(
        id: theId,
        name: name,
        link: link,
        companyName: companyName,
        platform: platform,
        description: description,
        location: location,
      );

      if (widget.jobaya != null) {
        await sqlDb.updateJob(JobTemplete);
      } else {
        await sqlDb.insertJob(JobTemplete);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.jobaya != null)
          ? AppBar(
              title: Text("Edit"),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: SingleChildScrollView(
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
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
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
              SizedBox(height: 25.h),
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
      ),
    );
  }
}
