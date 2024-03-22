class Note{
  String title;
  String description;

  Note({required this.title,required this.description});
  


  Note. FromNap(Map map):

  title=map["title"],
  description=map["description"];


  Map tomap(){
    return{
      "title":title,
      "description":description,
    };
  }
}