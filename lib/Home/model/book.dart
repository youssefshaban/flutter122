class book{
  int id;
  String title, Author , Description ;
  book({Title, author, description,ID}){
    this.Author=author;
    this.title=Title;
    this.Description=description;
    this.id=ID;
  }


  factory book.fromJson(Map<String, dynamic> json) {
    return book(
      Title: json['title'] as String,
      ID: json['id'] as int,
      author: json['author'] as String,
      description: json['description'] as String,
    );
  }
}