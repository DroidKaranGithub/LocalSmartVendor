class InquriesModalClass {
  String? id;
  String? title;
  String? product_url;
  String? user_id;
  String? dataStatus;
  String? is_vegue;
 String? audio_file;
  String? file_upload;
  String? description;
  String? category_id;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  String? date;
  String? category;
  InquriesFile? file;
  String? total_count;
  String? per_page;
  bool? status;

  InquriesModalClass({
    this.id,
    this.title,
    this.product_url,
    this.user_id,
    this.dataStatus,
    this.is_vegue,
       this.audio_file,
    this.file_upload,
    this.description,
    this.category_id,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.date,
    this.category,
    this.file,
    //this.total_count,
    //this.per_page,
  });

  factory InquriesModalClass.fromJson(Map<String, dynamic> jsonData) {
    // print(jsonData['id'].runtimeType);
    return InquriesModalClass(
      id: jsonData['id'].toString(),
      title: jsonData['title'].toString(),
      product_url: jsonData['product_url'].toString(),
      user_id: jsonData['user_id'].toString(),
      dataStatus: jsonData['status'].toString(),
      is_vegue: jsonData['is_vegue'].toString(),
      audio_file : jsonData['audio_file'].toString(),
      //audio_file: jsonData,
      file_upload: jsonData['file_upload'].toString(),
      description: jsonData['description'].toString(),
      category_id: jsonData['category_id'].toString(),
      created_at: jsonData['created_at'].toString(),
      updated_at: jsonData['updated_at'].toString(),
      deleted_at: jsonData['deleted_at'].toString(),
      date: jsonData['date'].toString(),
      category: jsonData['category'].toString(),
        file :
        jsonData['file'] != null ? new InquriesFile.fromJson(jsonData['file']) : null,
    );
  }
}



class InquriesFile {
  String? id;
  String? userId;
  String? name;
  String? description;
  String? fileName;
  String? fileSize;
  String? fileType;
  String? filePath;
  String? createdAt;
  String? updatedAt;

  InquriesFile(
      {this.id,
        this.userId,
        this.name,
        this.description,
        this.fileName,
        this.fileSize,
        this.fileType,
        this.filePath,
        this.createdAt,
        this.updatedAt});

  InquriesFile.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    fileName = json['file_name'].toString();
    fileSize = json['file_size'].toString();
    fileType = json['file_type'].toString();
    filePath = json['file_path'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['file_name'] = this.fileName;
    data['file_size'] = this.fileSize;
    data['file_type'] = this.fileType;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
