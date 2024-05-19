import { createRunOncePlugin } from "@expo/config-plugins";
import type { ConfigPlugin } from "@expo/config-plugins";
import type { AdMostPluginConfig } from "./config";
import { withAndroidConfig } from "./android";
import { withIosConfig } from "./ios";

const pak = require("../../package.json");

const withAdMost: ConfigPlugin<AdMostPluginConfig> = (config, { android, ios }) => {
  config = withAndroidConfig(config, android);
  config = withIosConfig(config, ios);

  return config;
};

export default createRunOncePlugin(withAdMost, pak.name, pak.version);
