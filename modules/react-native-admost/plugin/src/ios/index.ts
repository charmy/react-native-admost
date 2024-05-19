import { withInfoPlist, withPodfile, withXcodeProject, IOSConfig } from "@expo/config-plugins";
import { mergeContents } from "@expo/config-plugins/build/utils/generateCode";
import type { ConfigPlugin, InfoPlist, ExportedConfigWithProps, XcodeProject } from "@expo/config-plugins";
import type { AdMostIosConfig } from "../config";

function setAdmobAppId(file: InfoPlist, admobAppId: string) {
  file.GADApplicationIdentifier = admobAppId;
  return file;
}

function setSKAdNetworks(file: InfoPlist, skAdNetworks: string[]) {
  file.SKAdNetworkItems = skAdNetworks.map((v) => ({ SKAdNetworkIdentifier: v }));
  return file;
}

function mergePods(file: string, dependencies: string[]) {
  if (!dependencies || dependencies.length === 0) {
    return file;
  }

  return mergeContents({
    tag: "react-native-admost",
    src: file,
    newSrc: dependencies.map((d) => `  pod ${d}`).join("\n"),
    anchor: /config = use_native_modules!/,
    offset: 1,
    comment: "#",
  }).contents;
}

const mergeXcodeFrameworks = (config: ExportedConfigWithProps<XcodeProject>, frameworks: string[]) => {
  const target = IOSConfig.XcodeUtils.getApplicationNativeTarget({
    project: config.modResults,
    projectName: config.modRequest.projectName || "",
  });

  if (frameworks?.length > 0) {
    frameworks.forEach((f) => {
      config.modResults.addFramework(f, { target: target.uuid, weak: true });
    });
  }

  return config;
};

export const withIosConfig: ConfigPlugin<AdMostIosConfig> = (config, pluginConfig) => {
  config = withInfoPlist(config, (config) => {
    config.modResults = setAdmobAppId(config.modResults, pluginConfig.admobAppId);
    config.modResults = setSKAdNetworks(config.modResults, pluginConfig.skAdNetworks);
    return config;
  });

  config = withPodfile(config, (config) => {
    config.modResults.contents = mergePods(config.modResults.contents, pluginConfig.pods);
    return config;
  });

  config = withXcodeProject(config, (config) => {
    config.modResults.contents = mergeXcodeFrameworks(config, pluginConfig.frameworks);
    return config;
  });

  return config;
};
