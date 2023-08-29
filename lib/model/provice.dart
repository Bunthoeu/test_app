class Provice {
  int? id;
  Name? name;
  String? image;

  Provice({this.id, required this.name, required this.image});

  Provice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name=Name.fromJson(json['name']).toString() as Name?;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Name {
   String lain;
   String lains;

  Name({required this.lain, required this.lains});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      lain: json['lain'],
      lains: json['lains'],
    );
  }
}
