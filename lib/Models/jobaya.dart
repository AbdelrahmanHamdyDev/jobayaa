import 'package:flutter/material.dart';

enum Platform {
  Linkedin,
  Glassdoor,
  Indeed,
  Bayt,
  Wuzzuf,
  Naukrigulf,
  X,
  Whatsapp,
  Other,
}

final Map<Platform, Color> platformColors = {
  Platform.Linkedin: const Color(0xFF0077B5),
  Platform.Glassdoor: const Color(0xFF0CAA41),
  Platform.Indeed: const Color(0xFF003A9B),
  Platform.Bayt: const Color(0xFF003C9E),
  Platform.Wuzzuf: const Color(0xFF0059AB),
  Platform.Naukrigulf: const Color(0xFF000080),
  Platform.X: const Color(0xFF1DA1F2),
  Platform.Whatsapp: const Color(0xFF25D366),
  Platform.Other: const Color(0xFF808080),
};

final Map<Platform, String> platformIcons = {
  Platform.Linkedin:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmKF2o6JNLFVEhCjUFFHgcMowKESYKrIAwVQ&s",
  Platform.Glassdoor:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRqpSwvp1Q7h_a85yeSYMFYxrewCkjDeKIeQ&s",
  Platform.Indeed:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRMo7GE8v0GOTj7_JOpB2xIC3jbDRRkXLlkw&s",
  Platform.Bayt:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRpWr0TCvE1HYwJED2DfizxdpVz1nOrRz-FQ&s",
  Platform.Wuzzuf:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa-LAtpto1nEivVQC5XBvTd8IZ6NxXLm6Qpw&s",
  Platform.Naukrigulf:
      "https://play-lh.googleusercontent.com/gfznhMjjzcSoQrMczF7TNQcs5hcCUjV-zl6dz0moN_Er6cRdwUfgSDPFF2a-y-x59w=w240-h480-rw",
  Platform.X:
      "https://freepnglogo.com/images/all_img/1691832581twitter-x-icon-png.png",
  Platform.Whatsapp:
      "https://cdn-icons-png.freepik.com/256/15707/15707917.png?semt=ais_hybrid",
  Platform.Other:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4WBBP1hrvn0yLCamJMSxiLYvZ8ml5E72txw&s",
};

class job {
  const job({
    required this.id,
    required this.name,
    required this.link,
    required this.companyName,
    required this.platform,
    required this.description,
    required this.location,
  });

  final int? id;
  final String name;
  final String companyName;
  final String link;
  final Platform platform;
  final String description;
  final String location;

  factory job.fromMap(Map<String, dynamic> map) {
    return job(
      id: map['id'],
      name: map['name'],
      link: map['link'],
      companyName: map['company_name'],
      platform: Platform.values.firstWhere((e) => e.name == map['platform']),
      description: map['description'],
      location: map['location'],
    );
  }
}
