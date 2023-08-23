
class ReviewData {//unvisitedで使うコンストラクタ
  final String shopname;
  final String dishname;
  final int evaluate;
  final String content;
  final String created_at;
  final String image;

  ReviewData({
    required this.shopname,
    required this.dishname,
    required this.evaluate,
    required this.content,
    required this.created_at,
    required this.image,
  });
}