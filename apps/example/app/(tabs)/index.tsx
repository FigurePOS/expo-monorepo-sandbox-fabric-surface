import { Image, StyleSheet, Button } from "react-native";
import ParallaxScrollView from "@/components/ParallaxScrollView";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import TestPackageModule from "test-package";
import { useEffect } from "react";

export default function HomeScreen() {
  useEffect(() => {
    const sub = TestPackageModule.addListener("onChange", (event) => {
      console.log("TestPackageModule - onChange", event);
    });
    return () => {
      sub.remove();
    };
  }, []);
  return (
    <ParallaxScrollView
      headerBackgroundColor={{ light: "#A1CEDC", dark: "#1D3D47" }}
      headerImage={
        <Image
          source={require("@/assets/images/partial-react-logo.png")}
          style={styles.reactLogo}
        />
      }
    >
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title">Test Package</ThemedText>
      </ThemedView>
      <ThemedView>
        <Button
          title="Set Value"
          onPress={async () => {
            await TestPackageModule.setValueAsync("test");
          }}
        />
        <Button
          title="Hello"
          onPress={() => {
            const value = TestPackageModule.hello();
            console.log("TestPackageModule - Hello", value);
          }}
        />
      </ThemedView>
    </ParallaxScrollView>
  );
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
  },
  stepContainer: {
    gap: 8,
    marginBottom: 8,
  },
  reactLogo: {
    height: 178,
    width: 290,
    bottom: 0,
    left: 0,
    position: "absolute",
  },
});
