import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation de MobileAds
  await MobileAds.instance.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdMob Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables pour les publicités
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _rewardPoints = 0;

  // IDs de test AdMob
  final String _bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  final String _interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
  final String _rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Bannière chargée avec succès');
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Échec du chargement de la bannière: $error');
          ad.dispose();
        },
      ),
    );

    _bannerAd?.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('Interstitielle chargée avec succès');

          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _loadInterstitialAd(); // Recharger une nouvelle pub
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Échec affichage interstitielle: $error');
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Échec du chargement de l\'interstitielle: $error');
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          debugPrint('Pub récompensée chargée avec succès');

          _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              _loadRewardedAd(); // Recharger une nouvelle pub
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Échec affichage pub récompensée: $error');
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Échec du chargement de la pub récompensée: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd?.show();
    } else {
      debugPrint('Interstitielle pas encore chargée');
      // Optionnel: recharger la pub
      _loadInterstitialAd();
    }
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          setState(() {
            _rewardPoints += reward.amount.toInt();
          });
          debugPrint('Récompense gagnée: ${reward.amount} ${reward.type}');
        },
      );
    } else {
      debugPrint('Pub récompensée pas encore chargée');
      // Optionnel: recharger la pub
      _loadRewardedAd();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Points de récompense: $_rewardPoints',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showInterstitialAd,
                    child: const Text('Afficher Interstitielle'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _showRewardedAd,
                    child: const Text('Afficher Pub Récompensée'),
                  ),
                ],
              ),
            ),
          ),
          // Bannière en bas
          if (_bannerAd != null)
            Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}