import { StyleSheet, TextInput } from "react-native";

import ParallaxScrollView from "@/components/ParallaxScrollView";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { IconSymbol } from "@/components/ui/IconSymbol";
import { TestPackageView } from "test-package";

export default function TabTwoScreen() {
  return (
    <ParallaxScrollView
      headerBackgroundColor={{ light: "#D0D0D0", dark: "#353636" }}
      headerImage={
        <IconSymbol
          size={310}
          color="#808080"
          name="chevron.left.forwardslash.chevron.right"
          style={styles.headerImage}
        />
      }
    >
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title">Explore</ThemedText>
      </ThemedView>
      <ThemedView style={styles.contentContainer}>
        <ThemedText style={styles.hint}>
          Tap input → custom keyboard view will be shown
        </ThemedText>
        <TestPackageView style={styles.keyboardView}>
          <TextInput
            placeholder="Tap here"
            style={styles.textInput}
            keyboardType="default"
          />
        </TestPackageView>
      </ThemedView>
    </ParallaxScrollView>
  );
}

const styles = StyleSheet.create({
  headerImage: {
    color: "#808080",
    bottom: -90,
    left: -35,
    position: "absolute",
  },
  titleContainer: {
    flexDirection: "row",
    gap: 8,
  },
  contentContainer: {
    gap: 16,
    marginTop: 8,
  },
  hint: {
    opacity: 0.8,
    marginBottom: 8,
  },
  keyboardView: {
    borderRadius: 8,
    overflow: "hidden",
  },
  textInput: {
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    backgroundColor: "#fff",
    minHeight: 50,
  },
});
