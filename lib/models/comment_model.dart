class CommentModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? commentText;

  CommentModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.commentText,
  });

  CommentModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    commentText = json['commentText'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'commentText': commentText,
    };
  }
}
