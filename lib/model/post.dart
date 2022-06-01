class Post {
  String id;
  String content;
  String accountId;
  DateTime? createdTime;

  Post(
    {
      this.id = '',
      this.content = '',
      this.accountId = '',
      this.createdTime,
    }
  );
}