class NoteModel {
  final int? noteId;
  final String noteTitle;
  final String noteContent;
  //final String createdAt;
  final now = DateTime.now();
  NoteModel({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    //required this.createdAt,
   // required this.now,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        noteId: json["noteId"],
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
       // createdAt: json["CreatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "noteId": noteId,
        "noteTitle": noteTitle,
        "noteContent": noteContent,
       // "CreatedAt": createdAt,
      };
}
