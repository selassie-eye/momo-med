class CategoryTree {
  Map<String, dynamic> _tree;
  CategoryTree(this._tree);

  List<String> all() {
    List<String> ret = [];
    if(_tree.containsKey('id')) ret.add(_tree['id']);
    List<dynamic> children = _tree.containsKey('categories') ? _tree['categories'] : [];
    if (children != []) {
      children.forEach((cat) => ret.add(cat['id']));
    }
    return ret;
  }

}