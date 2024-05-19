import { AndroidConfig, withAndroidManifest, withAppBuildGradle, withProjectBuildGradle } from "@expo/config-plugins";
import { mergeContents } from "@expo/config-plugins/build/utils/generateCode";
import type { ConfigPlugin } from "@expo/config-plugins";
import type { AdMostAndroidConfig } from "../config";

const { addMetaDataItemToMainApplication, getMainApplicationOrThrow } = AndroidConfig.Manifest;

const setAdmobAppId = (androidManifest: AndroidConfig.Manifest.AndroidManifest, admobAppId: string) => {
  const mainApplication = getMainApplicationOrThrow(androidManifest);
  addMetaDataItemToMainApplication(mainApplication, "com.google.android.gms.ads.APPLICATION_ID", admobAppId);

  return androidManifest;
};

const mergeProjectBuildGradle = (file: string, dependencies: string[]) => {
  if (!dependencies || dependencies.length === 0) {
    return file;
  }

  return mergeContents({
    tag: "react-native-admost",
    src: file,
    newSrc: dependencies.map((d) => `        maven { url '${d}' }`).join("\n"),
    anchor: /maven(?:\s+)?\{.*}/,
    offset: 1,
    comment: "//",
  }).contents;
};

const mergeAppBuildGradle = (file: string, dependencies: string[]) => {
  if (!dependencies || dependencies.length === 0) {
    return file;
  }

  return mergeContents({
    tag: "react-native-admost",
    src: file,
    newSrc: dependencies.map((d) => `    implementation '${d}'`).join("\n"),
    anchor: /dependencies(?:\s+)?\{/,
    offset: 1,
    comment: "//",
  }).contents;
};

export const withAndroidConfig: ConfigPlugin<AdMostAndroidConfig> = (config, pluginConfig) => {
  config = withAndroidManifest(config, (config) => {
    config.modResults = setAdmobAppId(config.modResults, pluginConfig.admobAppId);
    return config;
  });

  config = withProjectBuildGradle(config, (config) => {
    config.modResults.contents = mergeProjectBuildGradle(config.modResults.contents, pluginConfig.extraMavenRepos);
    return config;
  });

  config = withAppBuildGradle(config, (config) => {
    config.modResults.contents = mergeAppBuildGradle(config.modResults.contents, pluginConfig.appBuildGradleRepos);
    return config;
  });

  return config;
};
