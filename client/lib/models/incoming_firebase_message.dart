class IncomingFirebaseMessage {
  String sender;
  String content;
  String type;

  IncomingFirebaseMessage({
    required this.sender,
    required this.content,
    required this.type,
  });

  factory IncomingFirebaseMessage.fromJson(Map<String, Object?> json) => IncomingFirebaseMessage(
    sender: json["sender"] as String,
    content: json["content"] as String,
    type: json["type"] as String,
  );
}
