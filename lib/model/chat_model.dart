class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String imageUrl;

  int id;

  ChatModel(
      {required this.name,
      required this.icon,
      required this.isGroup,
      required this.time,
      required this.id,
      required this.imageUrl});
}
