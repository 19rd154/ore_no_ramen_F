
class ReviewData {//reviewで使うコンストラクタ
final String shopid;
  final String reviewid;
  final String shopname;
  final String dishname;
  final int evaluate;
  final String content;
  final String created_at;
  final int bookmark;
  final String image;

  ReviewData({
    required this.shopid,
    required this.reviewid,
    required this.shopname,
    required this.dishname,
    required this.evaluate,
    required this.content,
    required this.created_at,
    required this.image,
    required this.bookmark,
  });
}