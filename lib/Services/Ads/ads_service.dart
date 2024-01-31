import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quitsmoke/Services/Ads/AdTypes/banner_ad.dart';
import 'package:quitsmoke/Services/Ads/AdTypes/native_ad.dart';

class AdsService {
  void init() {
    MobileAds.instance.initialize();
  }

  final bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  final interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  final nativeAdUnitId = 'ca-app-pub-3940256099942544/2247696110';

  InterstitialAd? _interstitialAd;

  get bannerAd => BannerAdWidget(adUnitId: bannerAdUnitId);

  nativeAd({required TemplateType templateType}) {
    return GoogleNativeAd(
      adUitId: nativeAdUnitId,
      templateType: templateType,
    );
  }

  Future<void> loadInterstitial(
    {
      required void Function() onAdLoaded,
      required void Function(LoadAdError error) onAdFailedToLoad
    }
  ) {
    return InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.show();
          onAdLoaded();
        },
        onAdFailedToLoad: (LoadAdError error) {
          onAdFailedToLoad(error);
        },
      )
    );
  }
}
