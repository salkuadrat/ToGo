import '../common/supabase.dart';
import '../models/models.dart';

class Api {
  static Future<List<Product>?> products(int page, {int limit = 10}) async {
    int from = (page - 1) * limit;
    int to = from + limit - 1;

    final res = await supabase
      .from('product')
      .select('*')
      .range(from, to)
      .execute();
    
    if (res.data is List) {
      return res.data.map<Product>((i) => Product.fromJson(i)).toList();
    }

    return null;
  }
}