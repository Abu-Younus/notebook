class Notebook{
  int? id;
  int? userid;
  String? title;
  String? content;
  String? date;

  Notebook({this.id, required this.title, this.content, this.date, this.userid});

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}