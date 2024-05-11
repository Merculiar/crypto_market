import 'package:crypto_app/common/consumer_state.dart';

class ConsumerData<T> {
  ConsumerData({
    this.data,
    this.error = '',
    this.state = ConsumerState.loading,
  });

  T? data;
  String error;
  ConsumerState state;
}
