class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map<String , dynamic> json)
  {

    text = json['text'];
    name=json['name'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    image=json['image'];
    postImage=json['postImage'];

  }

  Map<String , dynamic> toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'postImage':postImage,
      'dateTime':dateTime,
      'text':text,

    };
  }
}