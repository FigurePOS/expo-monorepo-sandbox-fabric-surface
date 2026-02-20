import { requireNativeView } from "expo";
import * as React from "react";

import { TestPackageViewProps } from "./TestPackage.types";

const NativeView: React.ComponentType<TestPackageViewProps> =
  requireNativeView("TestPackage");

export default function TestPackageView({
  children,
  ...props
}: TestPackageViewProps) {
  return <NativeView {...props}>{children}</NativeView>;
}
