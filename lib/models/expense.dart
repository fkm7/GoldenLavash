// To parse this JSON data, do
//
//     final expenseResponse = expenseResponseFromJson(jsonString);

import 'dart:convert';

ExpenseResponse expenseResponseFromJson(String str) => ExpenseResponse.fromJson(json.decode(str));

String expenseResponseToJson(ExpenseResponse data) => json.encode(data.toJson());

class ExpenseResponse {
  ExpenseResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Expense> results;

  ExpenseResponse copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<Expense> results,
  }) =>
      ExpenseResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) => ExpenseResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Expense>.from(json["results"].map((x) => Expense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Expense {
  Expense({
    this.id,
    this.count,
    this.countOld,
    this.price,
    this.amount,
    this.status,
    this.sendWarehouse,
    this.acceptedWarehouse,
    this.company,
    this.estimate,
    this.resource,
    this.provider,
  });

  int id;
  int count;
  int countOld;
  int price;
  int amount;
  int status;
  bool sendWarehouse;
  bool acceptedWarehouse;
  int company;
  int estimate;
  int resource;
  int provider;

  Expense copyWith({
    int id,
    int count,
    int countOld,
    int price,
    int amount,
    int status,
    bool sendWarehouse,
    bool acceptedWarehouse,
    int company,
    int estimate,
    int resource,
    int provider,
  }) =>
      Expense(
        id: id ?? this.id,
        count: count ?? this.count,
        countOld: countOld ?? this.countOld,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        sendWarehouse: sendWarehouse ?? this.sendWarehouse,
        acceptedWarehouse: acceptedWarehouse ?? this.acceptedWarehouse,
        company: company ?? this.company,
        estimate: estimate ?? this.estimate,
        resource: resource ?? this.resource,
        provider: provider ?? this.provider,
      );

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    count: json["count"],
    countOld: json["count_old"],
    price: json["price"],
    amount: json["amount"],
    status: json["status"],
    sendWarehouse: json["send_warehouse"],
    acceptedWarehouse: json["accepted_warehouse"],
    company: json["company"],
    estimate: json["estimate"],
    resource: json["resource"],
    provider: json["provider"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "count_old": countOld,
    "price": price,
    "amount": amount,
    "status": status,
    "send_warehouse": sendWarehouse,
    "accepted_warehouse": acceptedWarehouse,
    "company": company,
    "estimate": estimate,
    "resource": resource,
    "provider": provider,
  };
}