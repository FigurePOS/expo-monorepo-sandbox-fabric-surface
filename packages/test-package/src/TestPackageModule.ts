import { NativeModule, requireNativeModule } from "expo";

import { TestPackageModuleEvents } from "./TestPackage.types";

declare class TestPackageModule extends NativeModule<TestPackageModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<TestPackageModule>("TestPackage");
