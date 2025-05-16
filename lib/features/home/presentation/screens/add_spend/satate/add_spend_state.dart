class AddSpendState {
  final int spendMoney;
  final String spendDate;
  final String spendCategory;
  final String spendHead;
  final String spendDescription;

  AddSpendState({
    this.spendMoney = 0,
    this.spendDate = "",
    this.spendCategory = "",
    this.spendHead = "",
    this.spendDescription = "",
  });

  AddSpendState copyWith({
    int? spendMoney,
    String? spendDate,
    String? spendCategory,
    String? spendHead,
    String? spendDescription,
  }) {
    return AddSpendState(
      spendMoney: spendMoney ?? this.spendMoney,
      spendDate: spendDate ?? this.spendDate,
      spendCategory: spendCategory ?? this.spendCategory,
      spendHead: spendHead ?? this.spendHead,
      spendDescription: spendDescription ?? this.spendDescription,
    );
  }
}
