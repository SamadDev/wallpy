//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import connectivity_macos
import connectivity_plus_macos
import network_info_plus_macos
import package_info_plus
import path_provider_foundation
import shared_preferences_foundation
import sqflite
import url_launcher_macos
import wakelock_plus

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  NetworkInfoPlusPlugin.register(with: registry.registrar(forPlugin: "NetworkInfoPlusPlugin"))
  FLTPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))
  WakelockPlusMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockPlusMacosPlugin"))
}
