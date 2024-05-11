class ApiConstants {
  static String betaApiKey = 'CG-3bj3EbE4pBWrva7hi8nHove7';

  static Uri coinsListWithMarketDataUrl = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?x_cg_beta_api_key=$betaApiKey&vs_currency=usd&order=market_cap_desc&per_page=15&page=1');

  static Uri coinsFullDataByIdUrl(String id) {
    return Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$id?x_cg_beta_api_key=$betaApiKey&vs_currency=usd');
  }

  static Uri chartDataByDaysUrl(String id, int days) {
    return Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$id/market_chart?x_cg_beta_api_key=$betaApiKey&vs_currency=usd&days=$days');
  }
}
