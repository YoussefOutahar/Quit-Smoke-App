import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleNativeAd extends StatefulWidget {
  const GoogleNativeAd({super.key, required this.adUitId});
  final String adUitId;
  

  @override
  State<GoogleNativeAd> createState() => _GoogleNativeAdState();
}

class _GoogleNativeAdState extends State<GoogleNativeAd> {
  NativeAd? _nativeAd;
  bool _isNativeAdLoaded = false;
  bool _isLoading = false;

  void loadAd(){
    _isLoading = true;
    _nativeAd = NativeAd(
      adUnitId: widget.adUitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isNativeAdLoaded = true;
            _isLoading = false;
          });
          debugPrint("google ad loaded");
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            _isNativeAdLoaded = false;
            _isLoading = false;
          });
          debugPrint("google failed to load: $error");
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
    );
    _nativeAd?.load();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isNativeAdLoaded
      ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 350, minWidth: 100),
            child: AdWidget(ad: _nativeAd!)
          ),
        ): _isLoading ? const CircularProgressIndicator() : const SizedBox(),
      );
  }
}