

class Post_review {
  // コンストラクタ
  Post_review({
    required this.dishname,
    required this.content,
    required this.evaluate,
    required this.image,
    
  });

  // プロパティ
  String dishname;
  String content;
  int evaluate;
  String image;

  Map<String, dynamic> toJson() => {
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