export interface AdMostAndroidConfig {
  admobAppId: string;
  appBuildGradleRepos: string[];
  extraMavenRepos: string[];
}
export interface AdMostIosConfig {
  admobAppId: string;
  pods: string[];
  skAdNetworks: string[];
  frameworks: string[];
}

export interface AdMostPluginConfig {
  android: AdMostAndroidConfig;
  ios: AdMostIosConfig;
}
