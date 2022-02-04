class CategoryModalClass {
  String? id,
      name,
      status,
      is_parent,
      parent_id,
      biding_charge_price,
      hotdeals_price,
      created_at,
      updated_at,
      deleted_at;

  CategoryModalClass(
      {this.id,
      this.name,
      this.status,
      this.is_parent,
      this.parent_id,
      this.biding_charge_price,
      this.hotdeals_price,
      this.created_at,
      this.updated_at,
      this.deleted_at});

  factory CategoryModalClass.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModalClass(
        id: jsonData['id'].toString(),
        name: jsonData['name'].toString(),
        status: jsonData['status'].toString(),
        is_parent: jsonData['is_parent'].toString(),
        parent_id: jsonData['parent_id'].toString(),
        biding_charge_price: jsonData['biding_charge_price'].toString(),
        hotdeals_price: jsonData['hotdeals_price'].toString(),
        created_at: jsonData['created_at'].toString().substring(1, 8),
        updated_at: jsonData['updated_at'].toString().substring(1, 8),
        deleted_at: jsonData['deleted_at'].toString());
  }
}
