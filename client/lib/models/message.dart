class Message {
  int id;
  String body;
  String? sender;
  int sentInstant;

  Message({
    required this.id,
    required this.body,
    required this.sender,
    required this.sentInstant,
  });
}
