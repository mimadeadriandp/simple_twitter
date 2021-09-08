class ErrorEvent {
  String title;
  String content;
  String confirmText;
  Function onConfirm; 

  ErrorEvent({this.title, this.content, this.confirmText, this.onConfirm});
}