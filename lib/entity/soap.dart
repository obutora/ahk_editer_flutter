class Soap {
  final String id;
  final String soap; //S, O, A, EP, OP, CP
  final String body;

  Soap({required this.id, required this.soap, required this.body});

  @override
  String toString() => 'Soap{soap: $soap, body: $body}';

  factory Soap.fromJson(Map<String, dynamic> json) => Soap(
        id: json['id'] as String,
        soap: json['soap'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'soap': soap,
        'body': body,
      };
}

const SoapLabels = [
  '#',
  'S',
  'O',
  'A',
  'EP',
  'OP',
  'CP',
];
