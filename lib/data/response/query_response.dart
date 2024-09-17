import 'package:lecsens/data/response/status.dart';

class QueryResponse<T> {
  Status? status;
  String? message;
  T? data;

  QueryResponse(this.status, this.message, this.data);

  QueryResponse.loading() : status = Status.loading;
  QueryResponse.completed(this.data) : status = Status.completed;
  QueryResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "status : $status\n message : $message\n data : $data ";
  }
}
