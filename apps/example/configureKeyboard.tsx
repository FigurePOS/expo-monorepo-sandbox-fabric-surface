import { AppRegistry, View, Text } from "react-native";

import React from "react";
import { TestPackageView } from "test-package";

const CustomKeyboard = (
  _props: React.ComponentProps<typeof TestPackageView>,
) => (
  <View
    style={{
      flex: 1,
      justifyContent: "center",
      alignItems: "center",
      backgroundColor: "red",
    }}
  >
    <Text>Hello from TypeScript</Text>
  </View>
);

AppRegistry.registerComponent("custom-keyboard", () => CustomKeyboard);
