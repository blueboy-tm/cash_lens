class TransactionQueries {
  String? search;
  int? account;
  int page;

  TransactionQueries({
    this.search,
    this.account,
    this.page = 1,
  });
}
