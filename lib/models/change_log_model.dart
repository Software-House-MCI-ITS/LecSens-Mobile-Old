const String tableChangeLog = 'change_log';

class ChangeLogFields {
  static final List<String> values = [
    id, tableName, rowId, operation, timestamp
  ];

  static const String id = 'id';
  static const String tableName = 'table_name';
  static const String rowId = 'row_id';
  static const String operation = 'operation';
  static const String timestamp = 'timestamp';
}

class ChangeLog {
  final int? id;
  final String tableName;
  final int rowId;
  final String operation;
  final String timestamp;

  const ChangeLog({
    this.id,
    required this.tableName,
    required this.rowId,
    required this.operation,
    required this.timestamp,
  });

  ChangeLog copy({
    int? id,
    String? table_name,
    int? row_id,
    String? operation,
    String? timestamp,
  }) =>
      ChangeLog(
        id: id ?? this.id,
        tableName: table_name ?? this.tableName,
        rowId: row_id ?? this.rowId,
        operation: operation ?? this.operation,
        timestamp: timestamp ?? this.timestamp,
      );

  static ChangeLog fromJson(Map<String, Object?> json) => ChangeLog(
    id: json[ChangeLogFields.id] as int?,
    tableName: json[ChangeLogFields.tableName] as String,
    rowId: json[ChangeLogFields.rowId] as int,
    operation: json[ChangeLogFields.operation] as String,
    timestamp: json[ChangeLogFields.timestamp] as String,
  );

  Map<String, Object?> toJson() => {
    ChangeLogFields.id: id,
    ChangeLogFields.tableName: tableName,
    ChangeLogFields.rowId: rowId,
    ChangeLogFields.operation: operation,
    ChangeLogFields.timestamp: timestamp,
  };
}
