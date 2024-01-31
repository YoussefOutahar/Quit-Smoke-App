import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quitsmoke/Services/Ads/AdTypes/banner_ad.dart';

class AdsService {
  void init() {
    MobileAds.instance.initialize();
  }

  // ------------- BannerAd -------------
  final bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  get bannerAd => BannerAdWidget(adUnitId: bannerAdUnitId);

  // ------------- InterstitialAd -------------
  InterstitialAd? _interstitialAd;
  final interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';

  Future<void> loadInterstitial() {
    return InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('Hamid loaded.');
            _interstitialAd = ad;
            _interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
  // ------------- RewardedAd -------------
}
