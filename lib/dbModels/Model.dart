class UserModel {

  late final double _grams;
  late final double volume;
  late final double price;
  late final double density;
  late final double pounds;
  late final double perpounds;
  late final double karat;
  late final double totalamount;

  UserModel(this._grams, this.volume, this.price, this.density, this.pounds,
      this.perpounds, this.karat, this.totalamount);

  double get grams => _grams;

  set grams(double value) {
    _grams = value;
  }
}

