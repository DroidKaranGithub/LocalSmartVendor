class ResponseModalClass {
  String? id, //int
      title,
      product_url,
      user_id, //int
      status,
      is_vegue, //int
      file_upload,
      description,
      category_id, //int
      created_at,
      updated_at,
      deleted_at,
      date,
      category;
//skip
//audio_file
//file

  ResponseModalClass(
      {this.id,
      this.title,
      this.product_url,
      this.user_id,
      this.status,
      this.is_vegue,
      this.file_upload,
      this.description,
      this.category_id,
      this.created_at,
      this.updated_at,
      this.deleted_at,
      this.date,
      this.category});

  factory ResponseModalClass.fromJson(Map<String, dynamic> json) {
    return ResponseModalClass(
        id: json['id'].toString(),
        title: json['title'].toString(),
        product_url: json['product_url'],
        user_id: json['user_id'].toString(),
        status: json['status'].toString(),
        is_vegue: json['is_vegue'].toString(),
        file_upload: json['file_upload'],
        description: json['description'],
        category_id: json['category_id'].toString(),
        created_at: json['created_at'].toString(),
        updated_at: json['updated_at'].toString(),
        deleted_at: json['deleted_at'].toString(),
        date: json['date'].toString(),
        category: json['category'].toString());
  }
}
