

class Post_review {
  // コンストラクタ
  Post_review({
    required this.shop_id,
    required this.dishname,
    required this.content,
    required this.evaluate,
    required this.image,
    required this.bookmark,
  });

  // プロパティ
  String shop_id;
  String dishname;
  String content;
  int evaluate;
  String image;
  int bookmark;

  
  @override
  String toString() {
    return 'Post_review{shop_id: $shop_id, dishname: $dishname, content: $content, evaluate: $evaluate, bookmark:$bookmark, image: $image}';
  }

  Map<String, dynamic> toJson() => {
    'shop_id': shop_id,
    'dishname': dishname,
    'content': content,
    'evaluate': evaluate,
    'image': image,
  };
  
}

class ApiResults {
  
  ApiResults({
    required this.message,
  });
  final String message;
  factory ApiResults.fromJson(Map<String, dynamic> json) {
    return ApiResults(
      message: json['message'],
    );
  }
}