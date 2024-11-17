# ironsourceexemple

A new Flutter project.
# Flutter AdMob Integration

Ce projet montre l'implémentation complète de Google AdMob dans une application Flutter, incluant les bannières, interstitielles et publicités récompensées.

## 🚀 Configuration

### 1. Dépendances
Ajoutez la dépendance dans votre `pubspec.yaml` :
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_mobile_ads: ^3.0.0
```

Exécutez ensuite :
```bash
flutter pub get
```

### 2. Configuration Android
Dans `android/app/src/main/AndroidManifest.xml` :
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application>
        <!-- Pour le test -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713"/>
    </application>
</manifest>
```

### 3. Configuration iOS
Dans `ios/Runner/Info.plist` :
```xml
<dict>
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-3940256099942544~1458002511</string>
    <key>SKAdNetworkItems</key>
    <array>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>cstr6suwn9.skadnetwork</string>
        </dict>
    </array>
</dict>
```

## 📱 IDs de Test

### Android
- Banner: `ca-app-pub-3940256099942544/6300978111`
- Interstitial: `ca-app-pub-3940256099942544/1033173712`
- Rewarded: `ca-app-pub-3940256099942544/5224354917`

### iOS
- Banner: `ca-app-pub-3940256099942544/2934735716`
- Interstitial: `ca-app-pub-3940256099942544/4411468910`
- Rewarded: `ca-app-pub-3940256099942544/1712485313`

## 💻 Utilisation

1. Initialisez AdMob dans votre `main.dart` :
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}
```

2. Importez le package :
```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
```

## 🎯 Fonctionnalités

- ✅ Bannières publicitaires
- ✅ Publicités interstitielles
- ✅ Publicités récompensées
- ✅ Gestion des erreurs
- ✅ Mode test
- ✅ Chargement automatique

## 📝 Rappels importants

1. En développement :
   - Utilisez toujours les IDs de test
   - Activez le mode test
   - Ajoutez votre device ID pour les tests

2. Pour la production :
   - Changez les IDs de test par vos vrais IDs AdMob
   - Désactivez le mode test
   - Retirez les device IDs de test

## 🚧 Résolution des problèmes courants

1. **Les publicités ne se chargent pas :**
   - Vérifiez votre connexion internet
   - Confirmez que les IDs sont corrects
   - Assurez-vous que l'initialisation est terminée

2. **Erreur "No Ad Config" :**
   - Vérifiez la configuration dans AndroidManifest.xml et Info.plist
   - Assurez-vous que les IDs correspondent à la plateforme

3. **Publicités non visibles :**
   - Vérifiez que le widget AdMob a une taille définie
   - Confirmez que le chargement est réussi

## 📚 Documentation

Pour plus d'informations, consultez :
- [Documentation AdMob](https://developers.google.com/admob/flutter/quick-start)
- [google_mobile_ads package](https://pub.dev/packages/google_mobile_ads)

## 🔑 Bonnes pratiques

1. **Chargement des publicités :**
   - Pré-chargez les interstitielles et récompenses
   - Rechargez après chaque affichage
   - Gérez les erreurs de chargement

2. **Performance :**
   - Disposez les publicités quand elles ne sont plus nécessaires
   - Évitez de charger trop de publicités simultanément
   - Utilisez un état de chargement pour une meilleure UX

3. **Tests :**
   - Testez sur différents appareils
   - Vérifiez les performances avec et sans publicités
   - Testez la gestion des erreurs

## 📄 Licence

Ce projet est sous licence MIT.

---

⭐️ N'oubliez pas de mettre une étoile si ce projet vous a aidé !# flutterAdmob
