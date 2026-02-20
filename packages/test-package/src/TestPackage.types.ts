import type { ReactNode } from "react";
import type { StyleProp, ViewStyle } from "react-native";

export type TestPackageModuleEvents = {};

export type TestPackageViewProps = {
  children?: ReactNode;
  keyboardType?: string;
  style?: StyleProp<ViewStyle>;
};
