class Posts {

  int? id;
  String? title;
  String? body;

  Posts({required this.id,required this.title,required this.body});

  Posts.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
